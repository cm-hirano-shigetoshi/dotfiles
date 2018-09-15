#!/bin/sh

n=-100
if [ $# -ge 2 ] && echo "$1" | grep '^-\d\+' >/dev/null 2>&1; then
    n=$1
    shift
fi

branch=$(git branch | grep '^\*' | awk '{print $2}')
if [ -e "$1" ]; then
    git diff --color=always "$branch" "$1"
else
    if echo "$1" | grep "^${branch}\.\.\." >/dev/null 2>&1; then
        git diff --color=always $branch
    else
        echo "renamed or removed."
    fi
fi

