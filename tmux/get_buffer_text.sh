#!/bin/bash
set -eu

tmux new-window "\
  cat ~/.zsh/$1; \
  tmux capture-pane -p -S -1000 \
    | strutil newline -t=1 > ~/sample.txt \
"

