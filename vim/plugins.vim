let g:surround_no_mappings = 1
nmap S <Plug>Ysurround
xmap S <Plug>VSurround

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_migemo = 1
nmap s <Plug>(easymotion-overwin-f)
vmap s <Plug>(easymotion-bd-f)
omap s <Plug>(easymotion-bd-f)
omap F <Plug>(easymotion-bd-fl)
vmap F <Plug>(easymotion-bd-fl)
omap T <Plug>(easymotion-bd-tl)
vmap T <Plug>(easymotion-bd-tl)

nmap <Space><Space> viS

nmap <F8> <Plug>(CSVQ)

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
  packadd TimeMachine.vim
  packadd RecentUse.vim
  packadd FileSearch.vim
  packadd WordSearch.vim
  packadd SearchAllBuffers.vim
  packadd csvq.vim
augroup END

