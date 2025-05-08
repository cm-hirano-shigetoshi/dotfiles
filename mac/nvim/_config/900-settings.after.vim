autocmd FileType sql nnoremap <silent> mf :<C-u>%!format_sql<CR>
autocmd FileType typescript nnoremap <silent> mf :<C-u>%!format_ts<CR>
autocmd FileType python nnoremap <silent> mf :<C-u>%!format_python '%:p'<CR>
