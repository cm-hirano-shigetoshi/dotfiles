let g:surround_no_mappings = 1

function! DeleteSurround()
    let cursor_char = getline('.')[col('.') - 1]
    call feedkeys("\<Plug>Dsurround", "n")
    if cursor_char =~# '[[\]()<>{}"`'']'
        call feedkeys(cursor_char, "n")
    endif
endfunction

function! ReplaceSurround()
    let cursor_char = getline('.')[col('.') - 1]
    call feedkeys("\<Plug>Csurround", "n")
    if cursor_char =~# '[[\]()<>{}"`'']'
        call feedkeys(cursor_char, "n")
    endif
endfunction

xmap \ <Plug>VSurround
nmap \ <Plug>Ysurround
nnoremap <silent> d\ :call DeleteSurround()<cr>
nnoremap <silent> r\ :call ReplaceSurround()<cr>
