function set_pane_style() {
  local style
  style=$(grep '^Host .*#' ~/.ssh/config | strutil shift | sed 's/ *#/\t/' | strutil preg -1 "$*")
  if [[ -n "$style" ]]; then
    tmux select-pane -P "$style"
  fi
}

function ssh() {
  if [[ $- =~ i && -n $(printenv TMUX) ]] ; then
    #local pane_id=$(tmux display -p '#{pane_id}')
    #trap "tmux select-pane -t $pane_id -P 'default'" 1 2 3 15
    trap "tmux select-pane -P 'default'" 1 2 3 15

    set_pane_style "$0" "$@"

    command ssh $@

    #tmux select-pane -t $pane_id -P 'default'
    tmux select-pane -P 'default'
    trap 1 2 3 15
  else
    command ssh $@
  fi
}
