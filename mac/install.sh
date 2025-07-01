#!/usr/bin/env bash
set -veuo pipefail

SCRIPT_DIR=$(perl -MCwd=realpath -le 'print realpath shift' "$0/..")
PATH="$PATH:/opt/homebrew/bin"
PATH="$PATH:$HOME/.local/share/mise/installs/python/latest/bin"
PATH="$PATH:$HOME/.local/share/mise/installs/node/latest/bin"

function symlink_dir() {
    src=$1
    dst=$2
    [[ -L "$dst" ]] && rm -fr "$dst"
    ln -sf "$src" "$dst"
}


#
# Homebrew
#
if ! which brew; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

#
# Git
#
brew install git difftastic
mkdir -p $HOME/.config/
symlink_dir $SCRIPT_DIR/git $HOME/.config/git

#
# mise
#
if [[ ! -e "$HOME/.local/bin/mise" ]]; then
    curl https://mise.run | sh
fi

ln -sf $SCRIPT_DIR/mise $HOME/.config/mise
brew install xz
$HOME/.local/bin/mise install

#
# Rust
#
sh <(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs) -y

#
# Hammerspoon
#
ln -sf $SCRIPT_DIR/hammerspoon $HOME/.hammerspoon

#
# zsh
#
mkdir -p $HOME/.config/zsh
ln -sf $SCRIPT_DIR/zsh/zprofile $HOME/.zprofile
ln -sf $SCRIPT_DIR/zsh/zshenv $HOME/.zshenv
ln -sf $SCRIPT_DIR/zsh/zshrc $HOME/.zshrc
ln -sf $SCRIPT_DIR/zsh/p10k.zsh $HOME/.config/zsh/p10k.zsh
pip install requests # fzfのserverのために必要
brew install coreutils gnu-sed fzf ripgrep bat fd expect mdcat 1password-cli

#
# WezTerm
#
mkdir -p $HOME/.config/
rm -fr $HOME/.config/wezterm
symlink_dir $SCRIPT_DIR/wezterm $HOME/.config/wezterm

#
# Neovim
#
brew install neovim
mkdir -p $HOME/.config/nvim
ln -sf $SCRIPT_DIR/nvim/init.vim $HOME/.config/nvim/init.vim
ln -sf $SCRIPT_DIR/nvim/coc-settings.json $HOME/.config/nvim/coc-settings.json
symlink_dir $SCRIPT_DIR/nvim/_config $HOME/.config/nvim/_config
symlink_dir $SCRIPT_DIR/nvim/lua $HOME/.config/nvim/lua
nvim -c 'q!' sample.py
$HOME/.local/share/nvim/lazy-rocks/hererocks/bin/luarocks install luasocket
nvim \
    -c 'call feedkeys("\<Plug>fzf-file-selector", "n")' \
    -c '!(cd ~/.local/share/nvim/lazy/coc.nvim && npm ci)' \
    -c 'call feedkeys("Installation was Finished! You can close nvim.", "t")'j\
    sample.py
