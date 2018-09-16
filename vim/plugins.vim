augroup always-use-plugins
  autocmd!
  packadd github.com_junegunn_fzf.vim
  packadd github.com_junegunn_fzf
  packadd github.com_vim-scripts_surround.vim
augroup END

augroup nim-plugins
  autocmd!
  autocmd FileType nim packadd github.com_zah_nim.vim
augroup END
