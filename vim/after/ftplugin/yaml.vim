nnoremap <silent><buffer> <F7> :call Formatter()<CR>

function! Formatter()
    execute('%! yq --yaml-output .')
endfunction


