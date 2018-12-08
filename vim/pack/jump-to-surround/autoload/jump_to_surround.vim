scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

let s:targets = {
            \   '"' : 1,
            \   "'" : 1,
            \   '`' : 1,
            \   '(' : 1,
            \   '[' : 1,
            \   '{' : 1,
            \   '<' : 1,
            \ }

function! s:find_col()
    let i = col('.')
    while i <= len(getline('.'))
        let c = getline('.')[i]
        if has_key(s:targets, c)
            return i+1
        endif
        let i += 1
    endwhile
endfunction

function! s:find_char()
    let i = col('.')
    while i <= len(getline('.'))
        let c = getline('.')[i]
        if has_key(s:targets, c)
            return c
        endif
        let i += 1
    endwhile
endfunction

function! jump_to_surround#Jump()
    execute 'normal f' . s:find_char()
endfunction

function! jump_to_surround#NormalStr()
    return 'f' . s:find_char()
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

