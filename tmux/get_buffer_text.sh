#!/bin/bash
set -eu

mkdir -p ~/.zsh/buffer_history
readonly OUTPUT_FILE=~/.zsh/buffer_history/output.txt
rm -f ${OUTPUT_FILE}

readonly SPLIT_N=$((($(cat ~/.zsh/buffer_history/$1 | wc -l)-1) / 50000 + 1))
if [[ $SPLIT_N -gt 1 ]]; then
  readonly SESSION_N=$(tmux list-sessions | wc -l)
  for x in $(seq 0 $(($SPLIT_N - 1))); do
    tmux new-window "\
      ln -s lock ${OUTPUT_FILE}.${x}.lock
      cat ~/.zsh/buffer_history/$1 | \
        strutil line -0 $(($x*50000)):$((($x+1)*50000)); \
      tmux capture -t '$(($x+$SESSION_N)).0' -p -S - | \
        strutil newline -t=1 \
        > ${OUTPUT_FILE}.${x}; \
      rm ${OUTPUT_FILE}.${x}.lock
    "
    if [[ $x -gt 9 ]]; then
      break
    fi
  done
  while true; do
    if ls ${OUTPUT_FILE}.*.lock >/dev/null 2>&1; then
      sleep 1
    else
      break
    fi
  done
  cat ${OUTPUT_FILE}.* > ${OUTPUT_FILE}
else
  tmux capture-pane -p -S - | strutil newline -t=1 > ${OUTPUT_FILE}
fi

