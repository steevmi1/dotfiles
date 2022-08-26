# vim: filetype=sh
# things common to bourne shells

##echo "Entering .bourne-common.profile...."
##echo "MANPATH is ${MANPATH}"

case "$(command -v vim)" in
  */vim) VIM=vim ;;
  *)     VIM=vi  ;;
esac

export PATH=$HOME/bin:/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH
export EDITOR=$VIM
export FCEDIT=$EDITOR
export PAGER=less
export LESS='-iMRS -x2'
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export CLICOLOR=1
export GPG_TTY=$(tty)

##echo "Exiting .bourne-common.profile...."
##echo "MANPATH is ${MANPATH}"
