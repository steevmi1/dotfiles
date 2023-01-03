[ -f "$HOME/.kshrc.local" ] && source "$HOME/.kshrc.local"

. "$HOME/.bourne-common.rc"

HISTFILE=$HOME/.ksh_history
HISTSIZE=20000
TERM=xterm-256color

set -o emacs

case "$KSH_VERSION" in
  *PD*) # pdksh (OpenBSD)
    _XTERM_TITLE='\[\033]0;\u@\h:\w\007\]'
    _PS1_CLEAR='\[\033[0m\]'
    _PS1_BLUE='\[\033[34m\]'
    case "$(id -u)" in
      0) _PS1_COLOR='\[\033[1;31m\]' ;;
      *) _PS1_COLOR='\[\033[32m\]' ;;
    esac
    PS1='$_XTERM_TITLE\A $_PS1_COLOR\u@\h$_PS1_CLEAR:$_PS1_BLUE\w$_PS1_COLOR\$$_PS1_CLEAR '
    ;;
  *) # OS X (ksh93)
    _PS1_HOST=$(hostname -s)
    _PS1_CLEAR=$'\E[0m'
    _PS1_BLUE=$'\E[34m'
    case "$(id -u)" in
      0) _PS1_COLOR=$'\E[1;31m' ; _PS1_CHAR='#' ;;
      *) _PS1_COLOR=$'\E[32m' ; _PS1_CHAR='$' ;;
    esac
    PS1='$(date "+%H:%M") $_PS1_COLOR$USER@$_PS1_HOST$_PS1_CLEAR:$_PS1_BLUE${PWD/#$HOME/\~}$_PS1_COLOR$_PS1_CHAR$_PS1_CLEAR '
    ;;
esac
