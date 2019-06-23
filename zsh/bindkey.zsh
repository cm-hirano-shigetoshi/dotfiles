function __control_i {
  if [[ "${BUFFER}" = "aws " ]]; then
    zle fzf-aws-help
  else
    zle expand-or-complete
  fi
}
zle -N __control_i
bindkey "^i" __control_i

