#!/usr/bin/env bash
set -eu

dir=$(cd $(echo "$1" | sed "s%^~%$HOME%") && pwd)
readonly DEPTH=$(echo "${dir}" | tr '/' '\n' | wc -l)
if [[ ${DEPTH} -gt 3 ]]; then
  cd "${dir}" && find . 2>/dev/null | sed -e 's%//%/%g' -e 's%^\./%%'
else
  cd "${dir}" && find . -maxdepth 3 2>/dev/null | sed -e 's%//%/%g' -e 's%^\./%%'
fi

