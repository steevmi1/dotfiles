# vim: filetype=sh
# things common to bourne shells

##echo "Entering .bourne-common.profile...."
##echo "MANPATH is ${MANPATH}"

case "$(command -v vim)" in
  */vim) VIM=vim ;;
  *)     VIM=vi  ;;
esac

if test -d $HOME/bin; then
  PATH=$HOME/bin:${PATH}
fi
if test -d /opt/local/sbin; then
  PATH=/opt/local/sbin:${PATH}
fi
if test -d /opt/local/bin; then
  PATH=/opt/local/bin:${PATH}
fi
if test -d /opt/local/share/man; then
  MANPATH=/opt/local/share/man:${MANPATH}
fi
if test -d /usr/local/bin; then
  PATH=/usr/local/bin:${PATH}
fi

export MANPATH PATH
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
