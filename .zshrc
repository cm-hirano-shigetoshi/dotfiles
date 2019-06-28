if [ $# -eq 0 ] && [[ $0 =~ ^-?zsh$ ]]; then
  dotfiles=$(dirname $(readlink -e ~/.zshrc))
elif [ $# -eq 0 ] && [ "$0" = "$(which zsh)" ]; then
  dotfiles=$(dirname $(readlink -e ~/.zshrc))
else
  dotfiles=$(dirname $(readlink -e $0))
fi
for f in $dotfiles/zsh/*.zsh; do
    source $f
done

function zshaddhistory() {
    preexec_pipestatus "$@"
}

function preexec() {
    preexec_history "$@"
}

function chpwd() {
    chpwd_directory "$@"
}

function precmd() {
    PIPESTATUS=$pipestatus
    precmd_pipestatus $PIPESTATUS "$@"
    precmd_git $PIPESTATUS "$@"
}

### Added by Zplugin's installer
source '/Users/hirano.shigetoshi/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk
zplugin light zdharma/fast-syntax-highlighting
zplugin ice src"fzf-aws-help.zsh"; zplugin light cm-hirano-shigetoshi/fzf-aws-help

source ${DOTFILES}/zsh/bindkey.zsh
