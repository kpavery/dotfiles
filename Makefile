PATH := .:$(PATH)

all: brew brew-packages link archey zsh-plugins

clean: unlink

brew:
	@echo "Installing Homebrew..."
	@(is-executable brew && echo "brew already installed") || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | /usr/bin/ruby

stow: brew
	@echo "Installing stow..."
	@(is-executable stow && echo "stow already installed") || brew install stow

link: stow
	@echo "Linking config files..."
	@stow --dotfiles -t $(HOME) zsh

unlink: stow
	@echo "Removing config file links..."
	@stow --dotfiles --delete -t $(HOME) zsh

brew-packages: brew
	@echo "Installing Homebrew packages..."
	@brew bundle -q --file=install/Brewfile

archey: brew-packages
	@echo "Customizing archey..."
	@patch -N --dry-run --silent $(shell which archey) patches/archey.patch 1>/dev/null && patch $(shell which archey) patches/archey.patch || echo "archey already patched"

zsh-plugins: zsh-spaceship zsh-autosuggestions zsh-syntax-highlighting

zsh-spaceship:
	@echo "Installing spaceship prompt..."
	@(test -s $(HOME)/.oh-my-zsh/custom/themes/spaceship.zsh-theme && echo "spaceship already installed") || (git clone https://github.com/denysdovhan/spaceship-prompt.git $(HOME)/.oh-my-zsh/custom/themes/spaceship-prompt && ln -s $(HOME)/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme $(HOME)/.oh-my-zsh/custom/themes/spaceship.zsh-theme)

zsh-autosuggestions:
	@echo "Installing zsh auto suggestions..."
	@(test -d $(HOME)/.oh-my-zsh/custom/plugins/zsh-autosuggestions && echo "zsh auto suggestions already installed") || git clone https://github.com/zsh-users/zsh-autosuggestions $(HOME)/.oh-my-zsh/custom/plugins/zsh-autosuggestions

zsh-syntax-highlighting:
	@echo "Installing zsh syntax highlighting..."
	@(test -d $(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && echo "zsh syntax highlighting already installed") || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

