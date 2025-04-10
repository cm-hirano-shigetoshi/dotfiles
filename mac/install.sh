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
    version="2.1.1744318430" # 20250415 一時凌ぎのため
    packer_hererocks_home="$HOME/.cache/nvim/packer_hererocks"
    nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' | true
    if [[ ! -d $packer_hererocks_home/$AVAILABLE_VERSION ]]; then
        version=${version-$(ls -1 $packer_hererocks_home | grep '^\d' | sort -r | head -1)}
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

#
# Node
#
if ! which node; then
    $HOME/.local/bin/mise use --global node
fi

#
# Deno
#
if ! which deno; then
    $HOME/.local/bin/mise use --global deno
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
