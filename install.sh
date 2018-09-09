#!/bin/sh 

environment="linux_amd64"
if which sw_vers >/dev/null 2>&1 && sw_vers | grep 'ProductName:\s\+Mac OS X' >/dev/null 2>&1; then
    environment="darwin_amd64"
fi
develop=false
if [ $# -gt 0 ] && [ "$1" = "--dev" ]; then
    develop=true
    shift
fi

download() {
    git clone https://github.com/cm-hirano-shigetoshi/dotfiles
}

dotfiles() {
    cd $HOME
    for f in dotfiles/.??*; do
        if echo "$f" | grep '^dotfiles/\.git' >/dev/null 2>&1; then
            continue
        fi
        rm -f $(basename $f)
        ln -s $f $(basename $f)
    done
    cd dotfiles/bin
    for f in $environment/*; do
        rm -f $(basename $f)
        ln -s $f $(basename $f)
    done
    cd $OLDPWD
}

keybind() {
    cd $HOME
    if [ "$environment" = "darwin_amd64" ]; then
        mkdir -p .config/karabiner
        rm -f .config/karabiner/karabiner.json
        ln -s ~/dotfiles/keybind/karabiner.json .config/karabiner
    fi
}

vim() {
    cd $HOME
    mkdir -p .vim/backup
    mkdir -p .vim/pack/master/{opt,start}
    if $develop; then
        git clone https://github.com/zah/nim.vim .vim/pack/master/opt/github.com_zah_nim.vim
    fi
}

cui() {
    cd $HOME
    if $develop; then
        rm -fr cliutils
        git clone https://github.com/cm-hirano-shigetoshi/cliutils
    fi
}

fzf() {
    cd $HOME
    EXTERNAL_APP_PATH=${EXTERNAL_APP_PATH:-$HOME/local}
    if ! which fzf >/dev/null 2>&1; then
        mkdir -p ${EXTERNAL_APP_PATH}/bin
        wget https://github.com/junegunn/fzf-bin/releases/download/0.17.4/fzf-0.17.4-$environment.tgz
        tar xvf fzf-0.17.4-$environment.tgz
        mv fzf ${EXTERNAL_APP_PATH}/bin
        rm -f fzf-0.17.4-$environment.tgz
    fi
    git clone https://github.com/junegunn/fzf .vim/pack/master/opt/github.com_junegunn_fzf
    find .vim/pack/master/opt/github.com_junegunn_fzf -maxdepth 1 -mindepth 1 | grep -v 'plugin$' | xargs rm -fr
    git clone https://github.com/junegunn/fzf.vim .vim/pack/master/opt/github.com_junegunn_fzf.vim
    sed -e "s/\(return \['--prompt', head, '--query', tail\]\)$/\1 + get(g:, 'fzf_complete_path_options', [])/" .vim/pack/master/opt/github.com_junegunn_fzf.vim/autoload/fzf/vim/complete.vim > tmp
    mv tmp .vim/pack/master/opt/github.com_junegunn_fzf.vim/autoload/fzf/vim/complete.vim
}

nim() {
    cd $HOME
    if $develop; then
        if rm -fr /tmp/choosenim-0.3.2_$environment /tmp/untar-nim; then
            local count=0
            curl https://nim-lang.org/choosenim/init.sh -sSf > choosenim.sh
            while true; do
                sh choosenim.sh -y
                if [ $? -eq 0 ]; then
                    break
                fi
                count=$(($count + 1))
                if [ $count -ge 5 ]; then
                    echo "[41m[Error] Failed to installing nim.[0m"
                    break
                fi
            done
            rm -fr choosenim.sh /tmp/choosenim-0.3.2_$environment /tmp/untar-nim
        fi
    fi
}


if [ $# -eq 0 ]; then
    download
    dotfiles
    keybind
    vim
    cui
    fzf
    nim
else
    while [ ! -z "$1" ]; do
        $1
        shift
    done
fi

unset develop
unset environment
