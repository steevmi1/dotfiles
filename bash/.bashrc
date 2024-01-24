##echo "Entering .bashrc...."
##echo "MANPATH is ${MANPATH}"
##echo "PATH is ${PATH}"

##  Results in adding /usr/share/man twice, but at least makes sure that I have system man pages in there.
if test -z $MANPATH; then
  export MANPATH=/usr/share/man
else
  export MANPATH=${MANPATH}:/usr/share/man
fi

source "$HOME/.bourne-common.profile"
source "$HOME/.bourne-common.rc"

HISTFILESIZE=20000
HISTSIZE=10000

complete -c man which
complete -cf sudo

shopt -s histappend
shopt -s cmdhist
shopt -s checkwinsize

_PS1_CLEAR=$'\e[0m'
_PS1_BLUE=$'\e[34m'
case "$(id -u)" in
  0) _PS1_COLOR=$'\e[1;31m' ;;
  *) _PS1_COLOR=$'\e[32m' ;;
esac
PS1='\A \[${_PS1_COLOR}\]\u@\h\[$_PS1_CLEAR\]:\[$_PS1_BLUE\]\w\[$_PS1_COLOR\]\$\[$_PS1_CLEAR\] '

# change xterm title
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD/#$HOME/~}\007"'

# bash-completion
if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi

if test -f $HOME/bin/starship; then
    eval "$(starship init bash)"
fi

[ -f "$HOME/.bashrc.local" ] && source "$HOME/.bashrc.local"

##echo "Exiting .bashrc...."
##echo "PATH is ${PATH}"
##echo "MANPATH is ${MANPATH}"
