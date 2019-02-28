pass=$(OP_SESSION_classmethod=$(cat ~/.1password) op get totp aws)

if [[ $# -gt 0 ]]; then
  readonly PANE_ID=$1
  tmux send-keys -t ${PANE_ID} "${pass}" C-m
else
  echo "${pass}"
fi

