function! s:filetype_nim()
    packadd github.com_zah_nim.vim
    set filetype=nim
endfunction

augroup nim
  autocmd!
  autocmd BufNewFile,BufRead *.nim,*.nims,*.nimble call s:filetype_nim()
augroup END

augroup sql
  autocmd!
  autocmd BufNewFile,BufRead *.ddl,*.sql.vm set filetype=sql
augroup END

