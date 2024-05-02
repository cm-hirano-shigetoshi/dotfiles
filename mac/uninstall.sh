#!/usr/bin/env bash
set -veuo pipefail

SCRIPT_DIR=$(perl -MCwd=realpath -le 'print realpath shift' "$0/..")

#
# Neovim
#
if which brew && brew list | grep -x 'neovim'; then
    brew uninstall neovim
fi
/bin/rm -fr $HOME/.config/coc
/bin/rm -fr $HOME/.local/share/nvim
/bin/rm -fr $HOME/.config/nvim
/bin/rm -fr $HOME/.cache/nvim

#
# WezTerm
#
/bin/rm -fr $HOME/.config/wezterm

#
# zsh
#
/bin/rm -fr $HOME/.config/zsh
/bin/rm -f $HOME/.zprofile
/bin/rm -f $HOME/.zshenv
/bin/rm -f $HOME/.zshrc

#
# Rust
#
if which rustup; then
    rustup self uninstall -y
fi

#
# mise
#
if which mise; then
    mise implode -y
fi

#
# Homebrew
#
if which brew; then
    echo 'Y' | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
fi
[[ -e /opt/homebrew ]] && sudo /bin/rm -fr /opt/homebrew
