let g:fzf_files_options = ['-e', '--ansi', '--preview', g:dotfiles . '/zsh/lib/preview.sh {}', '--preview-window', 'top:60%']
let g:fzf_history_files_options = ['-e', '--ansi', '--preview', g:dotfiles . '/zsh/lib/preview.sh {}', '--preview-window', 'top:60%', '--no-sort']

nnoremap <S-Tab> :Files<CR>
nnoremap <Tab>f :History<CR>
nnoremap <Tab>b :Buffers<CR>
cnoremap <S-Tab> <C-b>Files <CR>
imap <S-Tab> <plug>(fzf-complete-path)

