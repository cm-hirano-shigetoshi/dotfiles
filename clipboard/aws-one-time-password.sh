#!/bin/bash
pass=$(OP_SESSION_classmethod=$(cat ~/.1password) op get totp aws)
if [[ -z "${pass}" ]]; then
  tmux split-window 'op signin classmethod --output=raw > ~/.1password'
  while pgrep -f 'op signin ' >/dev/null; do
    sleep 1
  done
  if [[ ! -s ~/.1password ]]; then
    exit
  fi
  pass=$(OP_SESSION_classmethod=$(cat ~/.1password) op get totp aws)
fi

if [[ $# -gt 0 ]]; then
  readonly PANE_ID=$1
  tmux send-keys -t ${PANE_ID} "${pass}" C-m
else
  echo "${pass}"
fi
