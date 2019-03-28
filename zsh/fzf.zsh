FZF_DEFAULT_OPTS=""
FZF_DEFAULT_OPTS+=" --exact --no-mouse --ansi --preview-window=up:wrap"
FZF_DEFAULT_OPTS+=" --bind='shift-up:preview-up,shift-down:preview-down,alt-up:preview-page-up,alt-down:preview-page-down,alt-p:toggle-preview,alt-c:execute-silent(echo -n {} | pbcopy)'"
FZF_DEFAULT_OPTS+=" --preview='echo {}'"
export FZF_DEFAULT_OPTS

