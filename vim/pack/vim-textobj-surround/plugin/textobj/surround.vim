if exists('g:loaded_textobj_surround')
  finish
endif

call textobj#user#plugin('quoted', {
\      '-': {
\        '*sfile*': expand('<sfile>:p'),
\        'select-a': 'aS',  '*select-a-function*': 's:select_a',
\        'select-i': 'iS',  '*select-i-function*': 's:select_i'
\      }
\    })

function! s:get_left(char_dict, from)
    if a:from > 1
        let left = getline('.')[:a:from-1]
        let i = a:from
        while i >= 0
            let i -= 1
            let c = left[i]
            if has_key(a:char_dict, c)
                return {'char':a:char_dict[c], 'pos':i+1}
            endif
        endwhile
    endif
    return {'char':"", 'pos':-1}
endfunction

function! s:get_right(char, from)
    let right = getline('.')[a:from:]
    let i = 0
    while i <= len(right)
        let i += 1
        let c = right[i-1]
        if c == a:char
            return a:from + i
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
\   }
    let from = col('.')-1
    while 1
        let left_char_pos = s:get_left(char_dict, from) "left_char_pos = {char, pos}
        if left_char_pos['pos'] < 0
            return []
        endif
        let right_pos = s:get_right(left_char_pos['char'], col('.')-1)
        if right_pos < 0
            let from = left_char_pos['pos']
            continue
        endif
        return [left_char_pos['pos'], right_pos]
    endwhile
endfunction

function! s:select_a()
    let range = s:get_range()
    if range != []
        let end_pos = getpos('.')
        let end_pos[2] = range[0]
        let start_pos = getpos('.')
        let start_pos[2] = range[1]
        return ['v', start_pos, end_pos]
    endif
endfunction

function! s:select_i()
    let range = s:get_range()
    if range != []
        let end_pos = getpos('.')
        let end_pos[2] = range[0]+1
        let start_pos = getpos('.')
        let start_pos[2] = range[1]-1
        return ['v', start_pos, end_pos]
    endif
endfunction

let g:loaded_textobj_surround = 1

