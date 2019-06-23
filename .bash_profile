export DOTFILES=${HOME}/dotfiles
if [[ $SHELL =~ bash$ ]]; then
    export EXTERNAL_APP_PATH=$HOME/local
    if [ -e $HOME/.nimble/bin/nim ]; then
        export NIM_HOME=$HOME/.nimble
    fi

    if which sw_vers >/dev/null 2>&1 && sw_vers | grep 'ProductName:\s\+Mac OS X' >/dev/null 2>&1; then
        source ~/.profile mac
    fi
    source ~/.profile windows
    export PATH

    if shopt -q login_shell; then
        if [ -f ~/.bashrc ]; then
            . ~/.bashrc
        fi
    fi
fi

