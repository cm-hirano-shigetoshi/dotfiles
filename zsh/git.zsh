function git-fetch() {
    if [ $(git fetch 2>&1 | wc -l) -gt 0 ]; then
        local branch
        branch=$(git branch | grep '^\s*\*' | awk '{print $2}')
        git diff $branch origin/$branch
    else
        echo "No updates"
    fi
}
alias gf='git-fetch'

if which fzf >/dev/null 2>&1; then
    function fzf-git-add() {
        local selected
        selected=($($dotfiles/bin/unbuffer git status -s | fzf --no-sort --reverse --ansi --preview="$dotfiles/zsh/lib/preview-git.sh {2..}" --preview-window=up:70% -m | awk '{print $2}'))
        if grep '\S' <<< "$selected" >/dev/null 2>&1; then
            sed -e 's/\s\+/\n/g' -e 's/^/add /' <<< "$selected"
            git add $selected
        fi
    }
    alias ga='fzf-git-add'

    function fzf-git-branch() {
        local selected
        selected=$(git branch -a --color=always | fzf --no-sort --reverse --ansi | sed -e 's/^\s*\*\?\s\+//' -e 's/ .*$//')
        if grep '\S' <<< "$selected" >/dev/null 2>&1; then
            git checkout $selected
        fi
    }
    alias gb='fzf-git-branch'

    function fzf-git-log-widget() {
        local selected
        selected=($(git log --graph --decorate --oneline --abbrev=40 --color=always | fzf --no-sort --reverse --ansi | grep -o '[0-9a-z]\{40\}'))
        if grep '\S' <<< "$selected" >/dev/null 2>&1; then
            BUFFER+="$selected"
            CURSOR=${#BUFFER}
            zle redisplay
            typeset -f zle-line-init >/dev/null && zle zle-line-init
        fi
    }
    zle -N fzf-git-log-widget
    bindkey "^g^l" fzf-git-log-widget

    function fzf-git-status-widget() {
        local selected
        selected=$($dotfiles/bin/unbuffer git status -sb | fzf -m --no-sort --reverse --ansi --preview="$dotfiles/zsh/lib/preview-git.sh {2..}" --preview-window=up:70%)
        if grep '\S' <<< "$selected" >/dev/null 2>&1; then
            BUFFER+=$(strutil de <<< $selected | strutil newline -r=' ')
            CURSOR=${#BUFFER}
            zle redisplay
            typeset -f zle-line-init >/dev/null && zle zle-line-init
        fi
    }
    zle -N fzf-git-status-widget
    bindkey "^g^s" fzf-git-status-widget
else
    alias ga='git add'
    alias gb='git branch; git chechout'
fi

precmd_git() {
    local branch
    branch=$(git branch 2>/dev/null)
    if [ $? -eq 0 ]; then
        branch=$(grep '^\s*\*' <<< $branch | awk '{print $2}')
        local change=""
        if [ $(git status -s | wc -l) -gt 0 ]; then
            change="*"
        fi
        PROMPT=$(strutil replace "%gb" " [35m($branch$change)[0m" <<< $PROMPT)
    else
        PROMPT=$(sed -e 's/%gb//' <<< $PROMPT)
    fi
}
