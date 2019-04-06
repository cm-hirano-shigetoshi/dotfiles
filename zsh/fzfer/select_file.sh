#!/usr/bin/env bash
set -eu

if [[ $# -gt 0 ]]; then
  if [[ -d "$1" ]]; then
    readonly DIR=$(cd $1 && pwd)
  else
    readonly DIR=$(cd $(dirname $1) && pwd)
  fi
  readonly DEPTH=$(echo ${DIR} | tr '/' '\n' | wc -l)
  if [[ ${DEPTH} -gt 3 ]]; then
    find ${DIR} 2>/dev/null | sed 's%^\./%%'
  else
    find ${DIR} -maxdepth 3 2>/dev/null | sed 's%^\./%%'
  fi
else
  readonly DEPTH=$(pwd | tr '/' '\n' | wc -l)
  if [[ ${DEPTH} -gt 3 ]]; then
    find . 2>/dev/null | sed 's%^\./%%'
  else
    find . -maxdepth 3 2>/dev/null | sed 's%^\./%%'
  fi
fi

