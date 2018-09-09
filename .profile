function mac() {
    PATH="/usr/local/Cellar/gnu-sed/4.5/libexec/gnubin:$PATH"
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
}

function windows() {
    local paths path ifs_tmp
    ifs_tmp=$IFS
    IFS=':' paths=($PATH); IFS=$ifs_tmp
    path=""
    for p in ${paths[@]}; do
        if [[ "$p" =~ ^/mnt/c/ ]]; then
            continue
        fi
        path+="$p:"
    done
    PATH=${path%:}
}

while [ $# -gt 0 ]; do
    $1
    shift
done

