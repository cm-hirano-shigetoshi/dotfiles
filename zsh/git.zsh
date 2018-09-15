function git-fetch() {
    local branch
    branch=$(git branch | grep '^\s*\*' | awk '{print $2}')
    git fetch 2>&1
    git diff $branch origin/$branch
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
        local query=""
        if [ $# -gt 0 ]; then
            if git branch | grep "^\s*$1" 2>&1 >/dev/null; then
                git checkout $1
                return
            else
                echo "No such branch: $1" >&2
                return 1
            fi
        fi
        local selected
        selected=$(git branch -a --color=always | fzf --no-sort --reverse --ansi --query="$query" | sed -e 's/^\s*\*\?\s\+//' -e 's/ .*$//')
        if grep '\S' <<< "$selected" >/dev/null 2>&1; then
            git checkout $selected
        fi
    }
    alias gb='fzf-git-branch'

    function fzf-git-log-widget() {
        local selected
        selected=($(git log --graph --decorate --oneline --abbrev=40 --color=always | fzf -m --no-sort --reverse --ansi --bind='tab:toggle+up,shift-tab:toggle+down' | grep -o '[0-9a-z]\{40\}'))
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
    git branch >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        local branch
        branch=$(git branch | grep '^\s*\*' | awk '{print $2}' 2>/dev/null)
        local change=""
        if git branch -a | grep "^\s*remotes/origin/$branch" >/dev/null 2>&1; then
            if [ $(git diff $branch origin/$branch | wc -l) -gt 0 ]; then
                change+="!"
            fi
        else
            change+="?"
        fi
        if [ $(git status -s | wc -l) -gt 0 ]; then
            change+="+"
        fi
        PROMPT=$(strutil replace "%gb" " [35m($change$branch)[0m" <<< $PROMPT)
    else
        PROMPT=$(sed -e 's/%gb//' <<< $PROMPT)
    fi
}
