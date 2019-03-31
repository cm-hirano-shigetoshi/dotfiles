function v() {
  local out
  out=$(~/PublicRepository/fzfer/fzfer.sh ~/dotfiles/zsh/fzfer/v.yml)
  if [[ -n "$out" ]]; then
    BUFFER="vim $out"
    zle accept-line
  fi
}
zle -N v
bindkey "^s" v

