export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="spaceship"

plugins=(
  brew
  cloudapp
  common-aliases
  git
  git-extras
  osx
  pip
  python
  sublime
  sudo
  wd
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Allows completion of _ with - and vice versa
HYPHEN_INSENSITIVE="true"

# Enables correction of commands
ENABLE_CORRECTION="true"

source $ZSH/oh-my-zsh.sh

# Include .zshrc.local, useful for local configuration which will not be checked in such as API keys
if [[ -a $HOME/.zshrc.local ]]; then
  . $HOME/.zshrc.local
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='subl -wn'
fi

# Spaceship theme options
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_DIR_TRUNC_PREFIX="…/"
SPACESHIP_GIT_STATUS_COLOR=magenta
SPACESHIP_CONDA_SYMBOL="🐍·"
SPACESHIP_CONDA_COLOR=white
SPACESHIP_EXEC_TIME_ELAPSED=10

# Set a few shortcuts for SSH connections
alias kpavery='ssh kpavery@kpavery.com'
alias pi='ssh keith@raspberrypi.local'

# Set an alias to update and upgrade Homebrew packages
alias bu="brew update; brew upgrade"

# Setup path
#
# Setup user home bin folder
path+=$HOME/bin
# Setup homebrew sbin
path+=$(brew --prefix)/sbin
# Setup subl
path+="/Applications/Sublime Text.app/Contents/SharedSupport/bin/"

export PATH

# Set up and down arrows to use local history
# CTRL-R and similar still use global history
up-line-or-local-history() {
    zle set-local-history 1
    zle up-line-or-history
    zle set-local-history 0
}
zle -N up-line-or-local-history
bindkey '^[OA' up-line-or-local-history     # Cursor up

down-line-or-local-history() {
    zle set-local-history 1
    zle down-line-or-history
    zle set-local-history 0
}
zle -N down-line-or-local-history
bindkey '^[OB' down-line-or-local-history   # Cursor down


# Run archey (system information display)
echo ""
archey -c -p
