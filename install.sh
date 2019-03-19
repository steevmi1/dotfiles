#!/bin/sh

DOTFILESDIR=$(pwd)
TIMESTAMP=$(date '+%Y%m%d.%H%M%S')

##  Shell and other basics
for file in .bashrc .bash_profile .bourne-common.profile .bourne-common.rc .dircolors .kshrc .profile .zshenv .zshrc
do
  if test -f $HOME/$file; then
    mv $HOME/$file $HOME/$file.$TIMESTAMP
  fi
done

for dir in bash bourne-common dircolors ksh zsh
do
  for file in $(find ./$dir -type f)
  do
    ln -s $DOTFILESDIR/$file $HOME/
  done
done

