echo "Entering .profile...."
echo "MANPATH is ${MANPATH}"

export ENV=$HOME/.kshrc
. "$HOME/.bourne-common.profile"

echo "Exiting .profile...."
echo "MANPATH is ${MANPATH}"
