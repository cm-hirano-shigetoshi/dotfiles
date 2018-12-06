scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! s:get_left(type)
    let left = getline('.')[:col('.')-2]
    let i = col('.')-1
    while i > 0
        let i -= 1
        let c = left[i]
        if a:type == 1 && c =~ '[^a-z]'
            return i + 1
        elseif a:type == 2 && c =~ '[^A-Z]'
            return i + 1
        elseif a:type == 3 && c =~ '[^0-9]'
            return i + 1
        endif
    endwhile
    return 0
endfunction

function! s:get_right(type)
    let right = getline('.')[col('.'):]
    let i = -1
    while i < len(right)-1
        let i += 1
        let c = right[i]
        if a:type == 1 && c =~ '[^a-z]'
            return col('.')-1 + i
        elseif a:type == 2 && c =~ '[^A-Z]'
            return col('.')-1 + i
        elseif a:type == 3 && c =~ '[^0-9]'
            return col('.')-1 + i
        endif
    endwhile
    return len(getline('.'))
endfunction

function! s:get_range()
    let c = getline('.')[col('.')-1]
    if c =~ '[a-z]'
        let type = 1
    elseif c =~ '[A-Z]'
        let type = 2
    elseif c =~ '[0-9]'
        let type = 3
    else
        return [col('.'), col('.')]
    endif
    let left = s:get_left(type)+1
    let right = s:get_right(type)+1
    return [left, right]
endfunction

function! textobj#group#select_a()
    let end_pos = getpos('.')
    let end_pos[2] = 1
    let start_pos = getpos('.')
    let start_pos[2] = 10
    return ['v', start_pos, end_pos]
endfunction

function! textobj#group#select_i()
    let range = s:get_range()
    if range != []
        let end_pos = getpos('.')
        let end_pos[2] = range[0]
        let start_pos = getpos('.')
        let start_pos[2] = range[1]
        return ['v', start_pos, end_pos]
    endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

