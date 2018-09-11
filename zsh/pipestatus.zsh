PRE_COMMAND=""

function preexec_pipestatus() {
    PRE_COMMAND=$1
}

function precmd_pipestatus() {
    PIPESTATUS=$1
    if [ ! -z $PRE_COMMAND ]; then
        STATUS=$(perl $dotfiles/zsh/lib/returnStatus.pl $PIPESTATUS)
        if [ $STATUS -eq 0 ]; then
            PROMPT=$'\n'$fg[white]"@END %D %* ["${PRE_COMMAND}"]"${reset_color}
        elif [ $STATUS -eq 1 ]; then
            PROMPT=$'\n'$fg[cyan]"@END %D %* ["${PRE_COMMAND}"]=>["${PIPESTATUS}"]"${reset_color}
        else
            PROMPT=$'\n'$fg[red]"@END %D %* ["${PRE_COMMAND}"]=>["${PIPESTATUS}"]"${reset_color}
        fi
        PROMPT+=$'\n'$PROMPT_BASE
    fi
}

