nnoremap <silent><buffer> <F7> :call CheckGoFormat()<CR>

function! CheckGoFormat()
    execute('%! gofmt')
endfunction


