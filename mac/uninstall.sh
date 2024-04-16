#!/usr/bin/env bash
set -veuo pipefail

SCRIPT_DIR=$(perl -MCwd=realpath -le 'print realpath shift' "$0/..")

#
# Neovim
#
brew uninstall neovim
rm -fr $HOME/.local/share/nvim
rm -fr $HOME/.config/nvim
rm -fr $HOME/.cache/nvim
