function fzf_history() {
  export PATH="~/local/bin:${PATH}"
  local readonly CLIPBOARD_HISTORY_FILE="${HOME}/.clipboard_history"
  local readonly YAML_FILE="${HOME}/dotfiles/clipboard/clipboard.yml"
  local result
  result=$(fzfyml run ${YAML_FILE})
  if [[ -z "${result}" ]]; then
    return
  fi
  local type
  type=$(head -1 <<< "${result}")
  if [[ "${type}" = "clipboard" ]]; then
    sed '1d' <<< "${result}" \
      | tr '' '\n' \
      | pbcopy
  elif [[ "${type}" = "edit" ]]; then
    local temp_file
    temp_file=$(mktemp "/tmp/clipboard_history.XXXXXX")
    sed '1d' <<< "${result}" \
      | tr '' '\n' \
      > ${temp_file}
    ${EDITOR-vim} ${temp_file}
    if [[ -s ${temp_file} ]]; then
      cat ${temp_file} | pbcopy
    fi
  fi
}
fzf_history

