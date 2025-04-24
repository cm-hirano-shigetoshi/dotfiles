autocmd FileType python nnoremap <silent> mf :<C-u>%!format_python '%:p'<CR>
autocmd FileType sql nnoremap <silent> mf :<C-u>%!format_sql<CR>
