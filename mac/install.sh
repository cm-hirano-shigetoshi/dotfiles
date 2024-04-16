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

function initialize_packer() {
    AVAILABLE_VERSION="2.1.0-beta3"
    packer_hererocks_home="$HOME/.cache/nvim/packer_hererocks"
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' | true
    if [[ ! -d $packer_hererocks_home/$AVAILABLE_VERSION ]]; then
        version=$(ls -1 $packer_hererocks_home | grep '^\d' | head -1)
        mv $packer_hererocks_home/$version $packer_hererocks_home/$AVAILABLE_VERSION
        ln -s $AVAILABLE_VERSION $packer_hererocks_home/$version
        MACOSX_DEPLOYMENT_TARGET=13.4 \
            python ~/.cache/nvim/packer_hererocks/hererocks.py \
            --verbose -r latest -j $AVAILABLE_VERSION \
            $packer_hererocks_home/$AVAILABLE_VERSION
    fi
}


#
# Homebrew
#
if ! which brew; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

#
# mise
#
brew install wget
if [[ ! -e "$HOME/.local/bin/mise" ]]; then
    curl https://mise.run | sh
fi

#
# Node
#
if ! which node; then
    $HOME/.local/bin/mise use --global node
fi

#
# Python
#
brew install xz
if ! which python; then
    $HOME/.local/bin/mise use --global python
fi

#
# Rust
#
if ! which cargo; then
    $HOME/.local/bin/mise use --global -y rust
fi

#
# zsh
#
mkdir -p $HOME/.config/zsh
ln -sf $SCRIPT_DIR/zsh/zprofile $HOME/.zprofile
ln -sf $SCRIPT_DIR/zsh/zshenv $HOME/.zshenv
ln -sf $SCRIPT_DIR/zsh/zshrc $HOME/.zshrc
ln -sf $SCRIPT_DIR/zsh/p10k.zsh $HOME/.config/zsh/p10k.zsh
pip install requests # fzfのserverのために必要

#
# brew install
#
brew install coreutils gnu-sed
brew install fzf
brew install ripgrep bat fd
brew install wget
brew install jq

#
# WezTerm
#
mkdir -p $HOME/.config/wezterm
ln -sf $SCRIPT_DIR/wezterm/wezterm.lua $HOME/.config/wezterm/wezterm.lua

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
initialize_packer
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
cd $PACKER_HOME/start/coc.nvim && npm ci
pip install ruff ruff-lsp

