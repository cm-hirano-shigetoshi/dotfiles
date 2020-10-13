nnoremap <silent><buffer> <F7> :call CheckFormat()<CR>

function! CheckFormat()
    execute('%!sqlformat')
endfunction


