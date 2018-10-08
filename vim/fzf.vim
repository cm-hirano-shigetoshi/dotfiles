let g:fzf_complete_path_options = ['-e', '--ansi', '--preview', g:dotfiles . '/zsh/lib/preview.sh {}', '--preview-window', 'right:70%']

nnoremap <S-Tab> :Files<CR>
nnoremap <Tab>f :History<CR>
nnoremap <Tab>b :Buffers<CR>
imap <S-Tab> <plug>(fzf-complete-path)

