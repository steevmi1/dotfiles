setopt no_global_rcs

##echo "Hit zshenv -- path is $PATH"

if test -f $HOME/.bourne-common.profile; then
  source "$HOME/.bourne-common.profile"
fi
if test -f $HOME/.bourne-common.rc; then
  source "$HOME/.bourne-common.rc"
fi

fpath=($HOME/.zsh $fpath)

if test -f /opt/homebrew/opt/lmod/init/zsh; then
    . /opt/homebrew/opt/lmod/init/zsh
    if test -d $HOME/.local/modules; then
        module use $HOME/.local/modules
##        module load mac/homebrew
    fi
    if test -d $HOME/.local/easybuild/modules; then
        module use $HOME/.local/easybuild/modules/all
    fi
fi

gpip() {
    PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

##  For homebrew
if test -d /opt/homebrew/opt/ruby/lib/pkgconfig; then
  PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig":$PKG_CONFIG_PATH
fi
if test -d /opt/homebrew/opt/openblas/lib/pkgconfig; then
  PKG_CONFIG_PATH="/opt/homebrew/opt/openblas/lib/pkgconfig":$PKG_CONFIG_PATH
fi

export LDFLAGS CPPFLAGS PKG_CONFIG_PATH PATH

if test -f /opt/homebrew/bin/gpgconf; then
  export GPG_TTY="$(tty)"
  export SSH_AUTH_SOCK=$(/opt/homebrew/bin/gpgconf --list-dirs agent-ssh-socket)
  /opt/homebrew/bin/gpgconf --launch gpg-agent
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

##echo "Leaving zshenv -- path is $PATH"
