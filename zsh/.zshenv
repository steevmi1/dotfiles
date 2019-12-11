setopt no_global_rcs

fpath=($HOME/.zsh $fpath)

if test -f /usr/local/opt/lmod/init/zsh; then
    . /usr/local/opt/lmod/init/zsh
    if test -d $HOME/modules; then
        module use $HOME/modules
        module load mac/homebrew
    fi
    if test -d $HOME/.local/easybuild/modules; then
        module use $HOME/.local/easybuild/modules/all
    fi
fi

if test -d /usr/X11/bin; then
    export PATH=${PATH}:/usr/X11/bin
fi

if test -d $HOME/miniconda3; then
    export PATH=$HOME/miniconda3/bin:$PATH
fi

gpip() {
    PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

##  For homebrew
if test -d /usr/local/opt/ruby/lib; then
  LDFLAGS="-L/usr/local/opt/ruby/lib "$LDFLAGS
  CPPFLAGS="-I/usr/local/opt/ruby/include "$CPPFLAGS
fi
if test -d /usr/local/opt/openblas/lib; then
  LDFLAGS="-L/usr/local/opt/openblas/lib "$LDFLAGS
  CPPFLAGS="-I/usr/local/opt/openblas/include "$CPPFLAGS
fi

if test -d /usr/local/opt/ruby/lib/pkgconfig; then
  PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig":$PKG_CONFIG_PATH
fi
if test -d /usr/local/opt/openblas/lib/pkgconfig; then
  PKG_CONFIG_PATH="/usr/local/opt/openblas/lib/pkgconfig":$PKG_CONFIG_PATH
fi

if test -d /usr/local/lib/ruby/gems/2.6.0/bin; then
  PATH=/usr/local/lib/ruby/gems/2.6.0/bin:$PATH
fi

export LDFLAGS CPPFLAGS PKG_CONFIG_PATH PATH

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(/usr/local/bin/gpgconf --list-dirs agent-ssh-socket)
/usr/local/bin/gpgconf --launch gpg-agent

# Tell homebrew to not autoupdate every single time I run it (just once a week).
export HOMEBREW_AUTO_UPDATE_SECS=604800

alias ssh="gpg-connect-agent updatestartuptty /bye > /dev/null;ssh"
