PATH := .:$(PATH)

all: brew brew-packages link archey

clean: unlink

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | /usr/bin/ruby

stow: brew
	is-executable stow || brew install stow

link: stow
	@stow --dotfiles -t $(HOME) zsh

unlink: stow
	@stow --dotfiles --delete -t $(HOME) zsh

brew-packages: brew
	brew bundle --file=install/Brewfile

archey: brew-packages
	patch -N --dry-run --silent $(shell which archey) patches/archey.patch 1>/dev/null && patch $(shell which archey) patches/archey.patch || echo "archey already patched"
