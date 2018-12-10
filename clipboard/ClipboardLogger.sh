export LANG=ja_JP.UTF-8
latest=""
while true; do
  s=$(pbpaste | tr '\n' '')
  if [[ "$s" != "$latest" ]]; then
    echo "$s" >> ~/.clipboard_history
    latest="$s"
  fi
  sleep 1
done

