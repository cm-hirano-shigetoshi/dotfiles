function fzf_history() {
  export PATH="~/local/bin:$PATH"
  local readonly CLIPBOARD_HISTORY_FILE="${HOME}/.clipboard_history"
  local text
  text=$(/usr/local/opt/coreutils/libexec/gnubin/tac "${CLIPBOARD_HISTORY_FILE}" \
          | grep -v '^\s*$' \
          | strutil unique \
          | fzf -m --preview="echo -n {} | sed -e 's//\n/g'" --preview-window='wrap' \
          | strutil newline -z \
          | sed 's//\n/g' \
        )
  if [[ $(wc -l <<< "${text}") -lt 2 ]]; then
    cat <<< "${text}" | strutil newline -z | pbcopy
  else
    cat <<< "${text}" | pbcopy
  fi
}
fzf_history
