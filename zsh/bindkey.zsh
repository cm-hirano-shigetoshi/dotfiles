function __control_h() {
  if [[ "${BUFFER}" = "aws " ]]; then
    zle fzf-aws-help
  else
    zle aws-resource-info
  fi
}
zle -N control-h __control_h
bindkey '^h' control-h
