PRE_TIME=""
PRE_COMMAND=""

function preexec_pipestatus() {
    PRE_TIME=$(date +%s)
    PRE_COMMAND=$(strutil newline -z <<< "$1")
}

function precmd_pipestatus() {
    local cur_time=$(date +%s)
    PIPESTATUS=$1
    if [[ -n $PRE_COMMAND ]]; then
        local duration=$(($cur_time - $PRE_TIME))
        STATUS=$(perl $dotfiles/zsh/lib/returnStatus.pl $PIPESTATUS)
        if [ $STATUS -eq 0 ]; then
          echo "\n[${PRE_COMMAND}] (${duration}s)"
        elif [ $STATUS -eq 1 ]; then
            echo "\n[36m[${PRE_COMMAND}]=>[${PIPESTATUS}] (${duration}s)[0m"
        else
            echo "\n[31m[${PRE_COMMAND}]=>[${PIPESTATUS}] (${duration}s)[0m"
        fi
        PROMPT=$PROMPT_BASE
    fi
}

