##echo "Entering .bash_profile...."
##echo "MANPATH is ${MANPATH}"

[ -f "$HOME/.bash_profile.local" ] && source "$HOME/.bash_profile.local"
source "$HOME/.bashrc"

##echo "Exiting .bash_profile...."
##echo "MANPATH is ${MANPATH}"
