function fzf_snippet() {
  export PATH="~/local/bin:$PATH"
  local readonly SNIPPET_FILE="${HOME}/.snippet"
  local text
  text=$(cat "${SNIPPET_FILE}" \
          | grep -v '^\s*$' \
          | strutil unique \
          | fzf -e --with-nth=1 --preview='echo {2..}' \
          | strutil shift \
        )
  if [[ -z "$text" ]]; then
    return
  fi
  if [[ $text = =* ]]; then
    eval "${text#=}" | strutil newline -z | pbcopy
  else
    echo $text | strutil newline -z | pbcopy
  fi
}
fzf_snippet

