scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

let s:targets = {
            \   '"' : 1,
            \   "'" : 1,
            \   '[' : 1,
            \   '{' : 1,
            \   '<' : 1,
            \   '(' : 1,
            \   '`' : 1,
            \ }

function! jump_to_surround#Jump()
    let i = col('.')
    while i <= len(getline('.'))
        let c = getline('.')[i]
        if has_key(s:targets, c)
            let pos = getpos('.')
            let pos[2] = i+1
            call setpos('.', pos)
            break
        endif
        let i += 1
    endwhile
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

