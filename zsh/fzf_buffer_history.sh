#!/bin/bash
set -eu

readonly START_OF_PROMPT="___START_OF_PROMPT___"

cat $1 | \
  sed -e "s/${HIDDEN_START_OF_PROMPT}/${START_OF_PROMPT}/g" | \
  remove_escapesequence | \
  tr '\n' '' | sed -e 's// /g' | \
  sed -e "s/${START_OF_PROMPT}/\n/g" | \
  fzf --with-nth 4.. --ansi --preview="echo {} | sed -e 's/ /\n/g' | strutil newline -l=0 -t=1" --preview-window='wrap' | \
  sed -e 's/ /\n/g' | \
  strutil newline -l=0 -t=1

