let g:surround_no_mappings = 1

function! DeleteSurround()
    let cursor_char = getline('.')[col('.') - 1]
    call feedkeys("\<Plug>Dsurround", "n")
    if cursor_char =~# '[[\]()<>{}"`'']'
        call feedkeys(cursor_char, "n")
    endif
endfunction

function! ChangeSurround()
    let cursor_char = getline('.')[col('.') - 1]
    call feedkeys("\<Plug>Csurround", "n")
    if cursor_char =~# '[[\]()<>{}"`'']'
        call feedkeys(cursor_char, "n")
    endif
endfunction

xmap s <Plug>VSurround
nmap s <Plug>Ysurround
nnoremap <silent> ds :call DeleteSurround()<cr>
nnoremap <silent> cs :call ChangeSurround()<cr>
