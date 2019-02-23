if [[ ! -z $TMUX ]]; then
  function __fzf_screen_buffer() {
    head -n -2 ~/.zsh/buffer_history/$$ | remove_escapesequence > ~/.screen_buffer
    LBUFFER+=$(strutil tokenize ~/.screen_buffer \
      | grep -v '^\s*$' \
      | tac \
      | strutil unique \
      | fzf -e -q "$BUFFER" -1 -0 \
    )
  }
  zle -N __fzf_screen_buffer
  bindkey "^s^s" __fzf_screen_buffer
fi
