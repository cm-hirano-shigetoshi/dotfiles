PRE_COMMAND=""

function preexec_pipestatus() {
    PRE_COMMAND=$1
}

function precmd_pipestatus() {
    PIPESTATUS=$1
    if [ ! -z $PRE_COMMAND ]; then
        STATUS=$(perl $dotfiles/zsh/lib/returnStatus.pl $PIPESTATUS)
        if [ $STATUS -eq 0 ]; then
            echo "\n@END [${PRE_COMMAND}]"
        elif [ $STATUS -eq 1 ]; then
            echo "\n[36m@END [${PRE_COMMAND}]=>[${PIPESTATUS}][0m"
        else
            echo "\n[31m@END [${PRE_COMMAND}]=>[${PIPESTATUS}][0m"
        fi
        PROMPT=$PROMPT_BASE
    fi
}

