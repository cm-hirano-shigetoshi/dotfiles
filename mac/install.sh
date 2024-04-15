#!/usr/bin/env bash
set -eu

SCRIPT_DIR=$(perl -MCwd=realpath -le 'print realpath shift' "$0/..")

function symlink_dir() {
    src=$1
    dst=$2
    [[ -L "$dst" ]] && rm -fr "$dst"
    ln -sf "$src" "$dst"
}


#
# mise
#
if [[ ! -e "$HOME/.local/bin/mise" ]]; then
    curl https://mise.run | sh
fi
if ! which node; then
    $HOME/.local/bin/mise use --global node
fi
if ! which python; then
    $HOME/.local/bin/mise use --global python
fi

#
# Rust
#
if ! which cargo; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

#
# Homebrew
#
if ! which brew; then
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

#
# brew install
#
brew install coreutils gnu-sed
brew install fzf
brew install ripgrep bat fd
brew install wget
brew install jq

#
# Neovim
#
brew install neovim
PACKER_HOME=$HOME/.local/share/nvim/site/pack/packer
mkdir -p $PACKER_HOME/start
[[ ! -d "$PACKER_HOME/start/packer.nvim" ]] && git clone --depth 1 https://github.com/wbthomason/packer.nvim $PACKER_HOME/start/packer.nvim
mkdir -p $HOME/.config/nvim
ln -sf $SCRIPT_DIR/nvim/init.vim $HOME/.config/nvim/init.vim
ln -sf $SCRIPT_DIR/nvim/coc-settings.json $HOME/.config/nvim/coc-settings.json
symlink_dir $SCRIPT_DIR/nvim/_config $HOME/.config/nvim/_config
symlink_dir $SCRIPT_DIR/nvim/lua $HOME/.config/nvim/lua
ln -sf $PACKER_HOME $HOME/.config/nvim/packer
#nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
#(cd $PACKER_HOME/start/coc.nvim && npm ci)
