if [[ -n $TMUX_PANE ]]; then
  tmux pipe-pane 'cat >> ~/.zsh/buffer_history/#{pane_pid}'
fi

