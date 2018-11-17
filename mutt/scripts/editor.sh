#!/bin/sh
if command -v vim > /dev/null ; then
    echo 'vim +1 -c "set textwidth=78" -c "set wrap" -c "set spell spelllang=en"'
else
    echo 'vi -c "set wraplen=72"'
fi
