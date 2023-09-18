" Vim 本体の機能のデフォルト値を変更する設定

if !has('win32') && !has('win64')
  setglobal shell=/bin/bash
endif

if exists('&termguicolors')
  setglobal termguicolors
endif

if exists('&completeslash')
  setglobal completeslash=slash
endif

" git commit 時にはプラグインは読み込まない
if $HOME != $USERPROFILE && $GIT_EXEC_PATH != ''
  finish
end

" プラグインの読み込み
let g:plug_shallow = 0

let g:python3_host_prog = $HOME . '/.asdf/shims/python'

call plug#begin('~/.config/nvim/plugged')

" IDEぽい環境の構築
Plug 'neoclide/coc.nvim'
"Plug 'davidhalter/jedi-vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'vijaymarupudi/nvim-fzf'
Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }

" 基本動作の拡張
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'mbbill/undotree'

" その他
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" プラグインテスト
Plug 'vim-jp/vital.vim'

" 自作お試し
"Plug 'cm-hirano-shigetoshi/VimFzfFileSelector'
"Plug 'cm-hirano-shigetoshi/fzf-file-selector.lua'
Plug 'cm-hirano-shigetoshi/fzf-file-selector.vim'
Plug 'cm-hirano-shigetoshi/fzf-grep.vim'

call plug#end()

" 各種設定の読み込み
call map(sort(split(globpath(&runtimepath, '_config/*.vim'))), {->[execute('exec "so" v:val')]})

