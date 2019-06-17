function fzf_aws_help {
  BUFFER=$(fzfer run ~/PublicRepository/fzf-aws-help/fzf-aws-help.yml)
  CURSOR=${#BUFFER}
  zle redisplay
}

