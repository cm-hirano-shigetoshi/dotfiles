#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(perl -MCwd=realpath -le 'print realpath shift' "$0/..")

#
# Rust
#
if ! builtin which cargo; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

#
# Homebrew
#
if ! builtin which brew; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

#
# WezTerm
#
mkdir -p $HOME/.config/wezterm
ln -sf $SCRIPT_DIR/wezterm/wezterm.lua $HOME/.config/wezterm/wezterm.lua

#
# zsh
#
mkdir -p $HOME/.config/zsh
ln -sf $SCRIPT_DIR/zsh/zprofile $HOME/.zprofile
ln -sf $SCRIPT_DIR/zsh/zshenv $HOME/.zshenv
ln -sf $SCRIPT_DIR/zsh/zshrc $HOME/.zshrc
ln -sf $SCRIPT_DIR/zsh/p10k.zsh $HOME/.config/zsh/p10k.zsh
