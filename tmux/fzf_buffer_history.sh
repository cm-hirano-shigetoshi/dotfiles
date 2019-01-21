#!/bin/bash
set -eu

cat $1 | \
  remove_escapesequence | \
  tr '\n' '' | \
  sed -e 's/___START_OF_PROMPT___/\n/g' | \
  fzf --ansi --preview="echo {} | sed -e 's//\n/g' | strutil newline -l=0 -t=1" --preview-window='wrap' | \
  sed -e 's//\n/g' | \
  strutil newline -l=0 -t=1

