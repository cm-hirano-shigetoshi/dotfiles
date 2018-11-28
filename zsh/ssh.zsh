function ssh() {
    if [[ $- =~ i && -n $(printenv TMUX) ]] ; then
        local pane_id=$(tmux display -p '#{pane_id}')
        trap "tmux select-pane -t $pane_id -P 'default'" 1 2 3 15

        if [[ "$*" =~ hogehoge- ]]; then
            tmux select-pane -P 'bg=colour52'
        fi

        command ssh $@

        tmux select-pane -t $pane_id -P 'default'
        trap 1 2 3 15
    else
        command ssh $@
    fi
}
