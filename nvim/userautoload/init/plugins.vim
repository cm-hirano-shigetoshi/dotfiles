call plug#begin('~/.local/share/nvim/plugged')
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/easymotion/vim-easymotion'
Plug 'https://github.com/cm-hirano-shigetoshi/WordSearch.vim'
Plug 'https://github.com/cm-hirano-shigetoshi/TimeMachine.vim'
Plug 'https://github.com/cm-hirano-shigetoshi/RecentUse.vim'
Plug 'https://github.com/cm-hirano-shigetoshi/FileSearch.vim'
Plug 'https://github.com/cm-hirano-shigetoshi/SearchAllBuffers.vim'
call plug#end()

"
"vim-surround
"
let g:surround_no_mappings = 1
nmap S <Plug>Ysurround
xmap S <Plug>VSurround

"
"vim-easymotion
"
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

