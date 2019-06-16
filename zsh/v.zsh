function v() {
  local out
  out=$(fzfer run ~/dotfiles/zsh/fzfer/v.yml)
  if [[ -n "$out" ]]; then
    BUFFER="vim $out"
    zle accept-line
  fi
}
zle -N v
#bindkey "v" v

