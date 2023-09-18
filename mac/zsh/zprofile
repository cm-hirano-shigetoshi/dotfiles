if which arch >/dev/null && [[ $(arch) = "arm64" ]]; then
    PATH="/opt/homebrew_x86/bin:$PATH"
    PATH="/opt/homebrew/bin:$PATH"
    PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
    PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
else
    PATH="/opt/homebrew_x86/bin:$PATH"
    PATH="/opt/homebrew_x86/opt/coreutils/libexec/gnubin:$PATH"
    PATH="/opt/homebrew_x86/opt/gnu-sed/libexec/gnubin:$PATH"
fi

export DOTFILES="$HOME/dotfiles.mac"
export EDITOR=vim

FZF_DEFAULT_OPTS=""
FZF_DEFAULT_OPTS+=" --exact --no-mouse"
FZF_DEFAULT_OPTS+=" --bind='ctrl-s:toggle-sort'"
export FZF_DEFAULT_OPTS

PATH="$HOME/bin/master:$PATH"

if [[ -s $HOME/company/.profile ]]; then
    source $HOME/company/.profile
fi

if echo $_ | grep -qF 'zsh'; then
    typeset -U path PATH
fi

