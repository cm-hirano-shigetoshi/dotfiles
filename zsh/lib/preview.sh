#!/bin/sh

n=-100
if [ $# -ge 2 ] && echo "$1" | grep '^-\d\+' >/dev/null 2>&1; then
    n=$1
    shift
fi

if [ ! -e $1 ]; then
    cmd=$(echo "$1" | strutil newline -z | sed -e 's/^\.\///')
    which $cmd
elif [ -f $1 ]; then
    if file $1 | grep '\(text\|empty\|: data$\)' >/dev/null 2>&1; then
        ls -lp --color=always $1 | sed -e 's/^/[30;46m/' -e 's/$/[0m/'
        echo ""
        head $n $1
    else
        ls -lp --color=always $1 | sed -e 's/^/[30;46m/' -e 's/$/[0m/'
        echo ""
        od -Ax -tx1z $1 | head $n
    fi
else
    ls -dlp --color=always $1 | sed -e 's/^/[30;46m/' -e 's/$/[0m/'
    echo ""
    unbuffer ls -a --color=always $1 | head $n
fi

