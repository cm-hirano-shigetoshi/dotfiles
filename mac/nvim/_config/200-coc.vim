function! s:show_documentation() abort
  if index(['vim','help'], &filetype) >= 0
    execute 'h ' . expand('<cword>')
  elseif coc#rpc#ready()
    call CocActionAsync('doHover')
  endif
endfunction

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> mrn <Plug>(coc-rename)
nnoremap <silent> K :<C-u>call <SID>show_documentation()<CR>
nnoremap <silent> <F1> :<C-u>call CocAction('diagnosticToggle')<CR>
nnoremap <silent> mf :<C-u>call CocAction('format')<CR>

