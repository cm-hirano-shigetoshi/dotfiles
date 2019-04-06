#!/usr/bin/env bash
set -eu

if [[ -d "$1" ]]; then
  echo "=== A01 $1 ===" >> ~/.debug
  readonly DIR=$(cd $1 && pwd)
else
  echo "=== A02 $1 ===" >> ~/.debug
  readonly DIR=$(cd $(dirname $1) && pwd)
fi
echo "=== A03 $DIR ===" >> ~/.debug
readonly DEPTH=$(echo ${DIR} | tr '/' '\n' | wc -l)
if [[ ${DEPTH} -gt 3 ]]; then
  cd ${DIR} && find . 2>/dev/null | sed 's%^\./%%'
else
  cd ${DIR} && find . -maxdepth 3 2>/dev/null | sed 's%^\./%%'
fi
