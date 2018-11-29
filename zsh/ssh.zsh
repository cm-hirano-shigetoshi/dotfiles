function set_pane_style() {
  grep '^\s*Host.*#\[[^\]\+\]$' ~/.ssh/config | while read line; do
    if grep "$(strutil island 2 <<< $line)" <<< "$*" >/dev/null 2>&1; then
      tmux select-pane -P "$(vimu 'df#xf]D' <<< $line)"
    fi
  done
}

function ssh() {
  if [[ $- =~ i && -n $(printenv TMUX) ]] ; then
    #local pane_id=$(tmux display -p '#{pane_id}')
    #trap "tmux select-pane -t $pane_id -P 'default'" 1 2 3 15
    trap "tmux select-pane -P 'default'" 1 2 3 15

    set_pane_style "$@"

    command ssh $@

    #tmux select-pane -t $pane_id -P 'default'
    tmux select-pane -P 'default'
    trap 1 2 3 15
  else
    command ssh $@
  fi
}
