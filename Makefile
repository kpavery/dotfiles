PATH := .:$(PATH)

all: brew brew-packages link

clean: unlink

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | /usr/bin/ruby

stow: brew
	is-executable stow || brew install stow

link: stow
	stow -t $(HOME) zsh

unlink: stow
	stow --delete -t $(HOME) zsh

brew-packages: brew
	brew bundle --file=install/Brewfile
