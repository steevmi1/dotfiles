setopt no_global_rcs

if test -f $HOME/.bourne-common.profile; then
  source "$HOME/.bourne-common.profile"
fi
if test -f $HOME/.bourne-common.rc; then
  source "$HOME/.bourne-common.rc"
fi

fpath=($HOME/.zsh $fpath)

if test -f /usr/local/opt/lmod/init/zsh; then
    . /usr/local/opt/lmod/init/zsh
    if test -d $HOME/.local/modules; then
        module use $HOME/.local/modules
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

if test -d $HOME/Library/Python/3.8/bin; then
  PATH=$HOME/Library/Python/3.8/bin:${PATH}
fi

export LDFLAGS CPPFLAGS PKG_CONFIG_PATH PATH

if test -f /usr/local/bin/gpgconf; then
  export GPG_TTY="$(tty)"
  export SSH_AUTH_SOCK=$(/usr/local/bin/gpgconf --list-dirs agent-ssh-socket)
  /usr/local/bin/gpgconf --launch gpg-agent
  alias ssh="gpg-connect-agent updatestartuptty /bye > /dev/null;ssh"
fi

# Tell homebrew to not autoupdate every single time I run it (just once a week).
export HOMEBREW_AUTO_UPDATE_SECS=604800

alias wx='curl '\''wttr.in/North Easton\ MA\ US?m'\'''
alias wx2='curl '\''v2.wttr.in/North Easton\ MA\ US?m'\'''
alias wxt='curl '\''wttr.in/North Easton\ MA\ US'\''\?format=3m'
alias wxm='curl '\''wttr.in/North Easton\ MA\ US'\''\?1pFnm'

if test -f ./src/personal/gruvbox/gruvbox_256palette_osx.sh; then
  source ./src/personal/gruvbox/gruvbox_256palette_osx.sh
fi

eval "$(/usr/libexec/path_helper)"
