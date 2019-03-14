FZF_DEFAULT_OPTS=""
FZF_DEFAULT_OPTS+=" --exact --no-mouse --ansi --preview-window=up"
FZF_DEFAULT_OPTS+=" --bind='up:preview-up,down:preview-down,alt-k:preview-page-up,alt-j:preview-page-down,alt-p:toggle-preview,alt-c:execute-silent(echo -n {} | pbcopy)'"
FZF_DEFAULT_OPTS+=" --preview='echo {}'"
export FZF_DEFAULT_OPTS

