#!/usr/bin/env
set -euo pipefail

TOOLDIR=$(dirname $0)

python "${TOOLDIR}/generate_rule.py" "${TOOLDIR}/karabiner.tsv" | jq | pbcopy

