### Added by Zplugin's installer
source '/Users/hirano.shigetoshi/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk
zplugin ice wait'!0'; zplugin light zdharma/fast-syntax-highlighting
zplugin ice wait'!0'; zplugin light cm-hirano-shigetoshi/clipboard-history
zplugin ice wait'!0' as"program" pick"bin/fzfyml"; zplugin light cm-hirano-shigetoshi/fzfyml
zplugin ice wait'!0' src"fzf-aws-help.zsh"; zplugin light cm-hirano-shigetoshi/fzf-aws-help
zplugin ice src"zshrc.sh"; zplugin light olivierverdier/zsh-git-prompt

if [ $# -eq 0 ] && [[ $0 =~ ^-?zsh$ ]]; then
  dotfiles=$(dirname $(readlink -e ~/.zshrc))
elif [ $# -eq 0 ] && [ "$0" = "$(which zsh)" ]; then
  dotfiles=$(dirname $(readlink -e ~/.zshrc))
else
  dotfiles=$(dirname $(readlink -e $0))
fi
for f in $dotfiles/zsh/*.zsh; do
    if [[ $f =~ bindkey ]]; then
        continue
    fi
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
}

source ${DOTFILES}/zsh/bindkey.zsh

