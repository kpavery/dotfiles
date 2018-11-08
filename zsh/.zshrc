export ZSH="/Users/kpavery/.oh-my-zsh"

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

# Miniconda (Python virtual environment manager)
. /Users/kpavery/miniconda3/etc/profile.d/conda.sh

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH
