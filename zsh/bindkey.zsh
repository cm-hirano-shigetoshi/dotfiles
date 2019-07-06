function __control_h() {
  local regexp='^aws\s*'
  if [[ "${BUFFER}" =~ $regexp ]]; then
    zle fzf-aws-help
  else
    zle backward-delete-char
  fi
}
zle -N control-h __control_h
bindkey '^h' control-h

