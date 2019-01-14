#!/bin/bash
set -eu

readonly OUTPUT_FILE=~/sample.txt
rm -f ${OUTPUT_FILE}

readonly SPLIT_N=$((($(cat ~/.zsh/$1 | wc -l)-1) / 50000 + 1))
if [[ $SPLIT_N -gt 1 ]]; then
  readonly SESSION_N=$(tmux list-sessions | wc -l)
  for x in $(seq 0 $(($SPLIT_N - 1))); do
    tmux new-window "\
      cat ~/.zsh/$1 | \
        strutil line -0 $(($x*50000)):$((($x+1)*50000)); \
      tmux capture -t '$(($x+$SESSION_N)).0' -p -S - | \
        strutil newline -t=1 \
        > ${OUTPUT_FILE}.${x}; \
    "
    if [[ $x -gt 9 ]]; then
      break
    fi
  done
else
  tmux capture-pane -p -S - | strutil newline -t=1 > ${OUTPUT_FILE}
fi

