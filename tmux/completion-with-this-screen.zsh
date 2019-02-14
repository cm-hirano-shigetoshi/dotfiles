if [[ ! -z $TMUX ]]; then
#  function aaa() {
#    BUFFER=$(tmux capture-pane -p | \
#      grep -v '^s*$' | grep -v '^\[' | grep -v '^\$' | \
#      sed 's/\s\+/\n/g' | \
#      tac | \
#      strutil unique | \
#      fzf -e -q "$BUFFER" -1
#    )
#  }
  function aaa() {
    BUFFER=$(cat ~/.zsh/buffer_history/$$ | \
      remove_escapesequence | \
      strutil tokenize | \
      grep -v '^\s*$' | \
      tac | \
      strutil unique | \
      fzf -e -q "$BUFFER" -1
    )
      #grep -v '^s*$' | grep -v '^\[' | grep -v '^\$' | \
  }
  zle -N aaa
  bindkey "^s^a" aaa
fi
