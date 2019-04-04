let g:surround_no_mappings = 1
nmap S <Plug>Ysurround
xmap S <Plug>VSurround

let g:EasyMotion_do_mapping = 0
map s <Plug>(easymotion-bd-f)

map f<CR> <Plug>(jump_to_surround#Jump)

nmap <Space> vi<Space>
nmap <Space><Space> viS

"ls ~/.vim/pack/master/opt
augroup always-use-plugins
  autocmd!
  packadd github.com_tpope_vim-repeat
  packadd github.com_tpope_vim-suround
  packadd github.com_junegunn_fzf.vim
  packadd github.com_junegunn_fzf
  packadd github.com_kana_vim-textobj-user
  packadd github.com_easymotion_vim-easymotion
  packadd github.com_nvie_vim-flake8
  packadd vim-textobj-surround
  packadd vim-textobj-group
  packadd jump-to-surround
augroup END

augroup nim-plugins
  autocmd!
  autocmd FileType nim packadd github.com_zah_nim.vim
augroup END

