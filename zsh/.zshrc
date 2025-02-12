##echo "Hit zshrc -- path is $PATH"
# If you come from bash you might have to change your $PATH.
##export PATH=${PATH}:/sbin/:/usr/sbin

##  Rework how path is getting built up -- /etc/zprofile on mac calls the path_helper executable,
##  which re-orders the paths and buries homebrew. Put this up at the top, otherwize oh-my-zsh can't
##  find things and will complain.

if test -f /usr/local/bin/brew; then
  ##  We're running homebrew on an older Mac......
  PATH=/usr/local/bin:/usr/local/sbin:${PATH}
else
  ##  See if we're running with a newer homebrew
  if test -d /opt/homebrew/sbin; then
    PATH=/opt/homebrew/sbin:${PATH}
  fi
  if test -d /opt/homebrew/bin; then
    PATH=/opt/homebrew/bin:${PATH}
  fi
fi
if test -d /usr/X11/bin; then
  PATH=/usr/X11/bin:${PATH}
fi
if test -d /Users/steevesm/Library/Python/3.9/bin; then
  PATH=/Users/steevesm/Library/Python/3.9/bin:${PATH}
fi
export PATH

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
##ZSH_THEME="ys"

##  Settings for spaceship theme
##export SPACESHIP_TIME_SHOW=true
##export SPACESHIP_USER_SHOW=always
##export SPACESHIP_HOST_SHOW=always
##export SPACESHIP_BATTERY_SHOW=always

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="%Y-%m-%d %T"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(ansible brew git tmux)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

##if test -f /usr/local/bin/chef; then
##  eval "$(chef shell-init zsh)"
##fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

##  If we have starship, configure and run
if test -f /usr/local/bin/starship; then
  eval "$(/usr/local/bin/starship init zsh)"
elif test -f /opt/local/bin/starship; then
  eval "$(/opt/local/bin/starship init zsh)"
elif test -f $HOME/bin/starship; then
  eval "$($HOME/bin/starship init zsh)"
fi
#
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/mds/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/mds/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/Users/mds/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/Users/mds/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/mds/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/Users/mds/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

##echo "Leaving zshrc -- path is $PATH"

