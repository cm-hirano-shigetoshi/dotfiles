scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! s:get_left(char_dict, from)
    let left = getline('.')[:a:from] "include cursor pos
    let i = a:from+1
    while i >= 0
        let i -= 1
        let c = left[i]
        if has_key(a:char_dict, c)
            return {'char':a:char_dict[c], 'pos':i}
        endif
    endwhile
    return {'char':"", 'pos':-1}
endfunction

function! s:get_right(char, from)
    let right = getline('.')[a:from+1:]
    let i = -1
    while i <= len(right)
        let i += 1
        let c = right[i]
        if c == a:char
            return a:from+1 + i
        endif
    endwhile
    return -1
endfunction

function! s:get_range()
    let char_dict = {
\       '"' : '"',
\       "'" : "'",
\       '`' : '`',
\       '[' : ']',
\       '(' : ')',
\       '{' : '}',
\       '<' : '>',
\   }
    let from = col('.')-1
    while 1
        let left_char_pos = s:get_left(char_dict, from) "left_char_pos = {char, pos}
        if left_char_pos['pos'] < 0
            return []
        endif
        let right_pos = s:get_right(left_char_pos['char'], col('.')-1)
        if right_pos < 0
            let from = left_char_pos['pos'] - 1
            continue
        endif
        return [left_char_pos['pos']+1, right_pos+1]
    endwhile
endfunction

function! textobj#surround#select_a()
    let range = s:get_range()
    if range != []
        let end_pos = getpos('.')
        let end_pos[2] = range[0]
        let start_pos = getpos('.')
        let start_pos[2] = range[1]
        return ['v', start_pos, end_pos]
    endif
endfunction

function! textobj#surround#select_i()
    let range = s:get_range()
    if range != []
        let end_pos = getpos('.')
        let end_pos[2] = range[0]+1
        let start_pos = getpos('.')
        let start_pos[2] = range[1]-1
        return ['v', start_pos, end_pos]
    endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

