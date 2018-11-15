export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="spaceship"

HYPHEN_INSENSITIVE="true"

ENABLE_CORRECTION="true"

plugins=(
  brew
  cloudapp
  common-aliases
  git
  gitextras
  osx
  pip
  python
  sublime
  sudo
  wd
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh


# User configuration

. $HOME/.zshrc.local

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

# Run archey (system information display)
archey -c -p

# Set up and down arrows to use local history and ctrl-r and similar to use global history
# ctrl-up and ctrl-down for global history stepping
bindkey "[A" up-line-or-local-history
bindkey "[B" down-line-or-local-history

up-line-or-local-history() {
    zle set-local-history 1
    zle up-line-or-history
    zle set-local-history 0
}
zle -N up-line-or-local-history
down-line-or-local-history() {
    zle set-local-history 1
    zle down-line-or-history
    zle set-local-history 0
}
zle -N down-line-or-local-history

bindkey "^[OA" up-line-or-history    # [CTRL] + Cursor up
bindkey "^[OB" down-line-or-history  # [CTRL] + Cursor down

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH
