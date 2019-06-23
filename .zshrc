### Added by Zplugin's installer
source '/Users/hirano.shigetoshi/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk
zplugin light zdharma/fast-syntax-highlighting
zplugin ice src"select_command/fzf-aws-help.zsh"; zplugin light cm-hirano-shigetoshi/fzf-aws-help


source ${DOTFILES}/zsh/common.zsh
source ${DOTFILES}/zsh/bindkey.zsh


