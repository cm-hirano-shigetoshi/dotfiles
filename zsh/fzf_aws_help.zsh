function fzf_aws_help {
  if [[ "${BUFFER}" =~ aws* ]]; then
    BUFFER=$(fzfer run ~/PublicRepository/fzf-aws-help/fzf-aws-help.yml)
    CURSOR=${#BUFFER}
    zle redisplay
  fi
}

