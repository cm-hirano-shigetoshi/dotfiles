#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(perl -MCwd=realpath -le 'print realpath shift' "$0/..")

#
# WezTerm
#
mkdir -p $HOME/.config/wezterm
ln -sf $SCRIPT_DIR/wezterm/wezterm.lua $HOME/.config/wezterm/wezterm.lua

#
# zsh
#
echo 'export ZDOTDIR=$HOME/.config/zsh' > $HOME/.zshenv
mkdir -p $HOME/.config/zsh
ln -sf $SCRIPT_DIR/zsh/zprofile $HOME/.config/zsh/zprofile
ln -sf $SCRIPT_DIR/zsh/zshenv $HOME/.config/zsh/zshenv
ln -sf $SCRIPT_DIR/zsh/zshrc $HOME/.config/zsh/zshrc
ln -sf $SCRIPT_DIR/zsh/p10k.zsh $HOME/.config/zsh/p10k.zsh
