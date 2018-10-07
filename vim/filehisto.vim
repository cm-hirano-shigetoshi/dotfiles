function! s:addHistory()
    let l:history = '~/.vim/history'
    execute ":redir! >> " . l:history
        silent! echo expand("<afile>:p")
    redir END
endfunction

autocmd! BufRead,BufWrite,BufNewFile * call s:addHistory()

