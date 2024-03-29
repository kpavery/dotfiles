PATH := .:$(PATH)

all: brew brew-packages oh-my-zsh zsh-plugins hushlogin link git binaries

clean: unlink

brew:
	@echo "Installing Homebrew..."
	@(is-executable brew && echo "brew already installed") || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 

stow: brew
	@echo "Installing stow..."
	@(is-executable stow && echo "stow already installed") || brew install stow

link: stow
	@echo "Linking config files..."
	@(test -e $(HOME)/.zshrc && test ! -L $(HOME)/.zshrc && rm $(HOME)/.zshrc) || true
	@stow --dotfiles -t $(HOME) zsh

git: stow
	@echo "Updating git config..."
	@stow --dotfiles -t $(HOME) git
	@(git config --global include.path .gitconfig.global)

unlink: stow
	@echo "Removing config file links..."
	@stow --dotfiles --delete -t $(HOME) zsh

brew-packages: brew
	@echo "Installing Homebrew packages..."
	@brew bundle --file=install/Brewfile

binaries:
	@echo "Installing binaries..."
	@(test -d $(HOME)/bin || mkdir $(HOME)/bin)
	@stow -t $(HOME)/bin bin

zsh-plugins: zsh-spaceship zsh-autosuggestions zsh-syntax-highlighting conda-zsh-completion

zsh-spaceship: oh-my-zsh
	@echo "Installing spaceship prompt..."
	@(test -s $(HOME)/.oh-my-zsh/custom/themes/spaceship.zsh-theme && echo "spaceship already installed") || (git clone https://github.com/denysdovhan/spaceship-prompt.git $(HOME)/.oh-my-zsh/custom/themes/spaceship-prompt && ln -s $(HOME)/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme $(HOME)/.oh-my-zsh/custom/themes/spaceship.zsh-theme)

zsh-autosuggestions: oh-my-zsh
	@echo "Installing zsh auto suggestions..."
	@(test -d $(HOME)/.oh-my-zsh/custom/plugins/zsh-autosuggestions && echo "zsh auto suggestions already installed") || git clone https://github.com/zsh-users/zsh-autosuggestions.git $(HOME)/.oh-my-zsh/custom/plugins/zsh-autosuggestions

zsh-syntax-highlighting: oh-my-zsh
	@echo "Installing zsh syntax highlighting..."
	@(test -d $(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && echo "zsh syntax highlighting already installed") || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $(HOME)/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

conda-zsh-completion: oh-my-zsh
	@echo "Installing conda zsh completion..."
	@(test -d $(HOME)/.oh-my-zsh/custom/plugins/conda-zsh-completion && echo "conda zsh completion already installed") || git clone https://github.com/esc/conda-zsh-completion.git $(HOME)/.oh-my-zsh/custom/plugins/conda-zsh-completion

oh-my-zsh: SHELL := /bin/zsh
oh-my-zsh:
	@echo "Installing oh my zsh..."
	@(test -d $(HOME)/.oh-my-zsh && echo "oh my zsh already installed") || sh <(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --unattended

hushlogin:
	@echo "Removing login message..."
	@(test -f $(HOME)/.hushlogin && echo "Message already removed") || touch $(HOME)/.hushlogin
