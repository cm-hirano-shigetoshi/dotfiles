nnoremap <silent><buffer> <F7> :call CheckPythonFormat()<CR>

function! CheckPythonFormat()
    execute('%! yapf')
    call flake8#Flake8()
endfunction

