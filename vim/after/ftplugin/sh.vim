nnoremap <silent><buffer> <F7> :call CheckFormat()<CR>

function! CheckFormat()
    execute('%! shfmt -i 2')
endfunction

