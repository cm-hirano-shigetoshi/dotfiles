#!/bin/bash
set -eu

readonly START_OF_PROMPT="___START_OF_PROMPT___"

cat $1 | \
  remove_escapesequence -s ${START_OF_PROMPT} | \
  tr '\n' '' | \
  sed -e "s/${START_OF_PROMPT}/\n/g" | \
  fzf --ansi --preview="echo {} | sed -e 's//\n/g' | strutil newline -l=0 -t=1" --preview-window='wrap' | \
  sed -e 's//\n/g' | \
  strutil newline -l=0 -t=1

