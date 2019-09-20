# kpavery's dotfiles

This repository contains my z shell dotfiles, my homebrew package list, some small customizations for archey, and a makefile to install and set everything up.

### Installing

Check out this repository to somewhere like `~/.dotfiles`. Then run the makefile with `make`.

The makefile will:
- Install homebrew
- Install my list of brew packages
- Install [oh my zsh](https://github.com/robbyrussell/oh-my-zsh)
- Link the dotfiles into the home directory with `stow` (a reversible symlink utility)
- Patch archey with my custom tweaks to color, formatting, and information displayed
- Install the [Spaceship](https://github.com/denysdovhan/spaceship-prompt) zsh theme
- Install the [autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) zsh plugin
- Install the [syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) zsh plugin
- Remove / hush the login message

The above steps will only be performed if the relevant command, plugin, or theme is not already present in the expected location.
