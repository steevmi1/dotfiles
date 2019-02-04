setopt no_global_rcs

fpath=($HOME/.zsh $fpath)

function start_agent {
    echo "Initializing new ssh agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > $SSH_ENV
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ "X${hns}X" = "Xuscalx1114X" ]; then
    if [ -f "${SSH_ENV}" ]; then
	. "${SSH_ENV}" > /dev/null
	ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
	    start_agent;
	}
    else
	start_agent;
    fi 
fi

if test -f /usr/local/opt/lmod/init/zsh; then
    . /usr/local/opt/lmod/init/zsh
    if test -d $HOME/.local/modules; then
        module use $HOME/.local/modules
        module load aws/accounts/SciComp-HPC_dev
        module load aws/regions/us-east-1
        module load NIBR/proxies/GLOBAL
        module load mac/homebrew
        module load steevmi1
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
  LDFLAGS="-L/usr/local/opt/ruby/lib"
  CPPFLAGS="-I/usr/local/opt/ruby/include"
fi

if test -d /usr/local/opt/ruby/lib/pkgconfig; then
  PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"
fi

if test -d /usr/local/lib/ruby/gems/2.6.0/bin; then
  PATH=/usr/local/lib/ruby/gems/2.6.0/bin:$PATH
fi

export LDFLAGS CPPFLAGS PKG_CONFIG_PATH PATH
