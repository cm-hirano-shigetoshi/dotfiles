" 書き込み権限がないとき、!をつけても上書きしない
set cpoptions+=W
" 折り返したときは行番号の部分にも描画する
set cpoptions+=n
" 現在のバッファに変更があっても他のバッファに移れる
set hidden
" 行番号を表示
set number
" タブなどに対して薄く文字を表示する
set list
" 表示する文字の設定
set listchars=tab:>\ ,trail:_,nbsp:%
" 折り返ししない
set nowrap
" タブの代わりに空白を挿入
set expandtab
" タブは4文字
set tabstop=4
" 自動挿入されるタブも4文字
set shiftwidth=4
" 先頭の空白だけBackspaceでタブのように消す
set smarttab
" タブインデント行を<<した時に空白にしない
set preserveindent
" タブインデント行の次はタブにする。が効いていない？
set copyindent
" ファイル名補完では大文字小文字を区別しない
set fileignorecase
" =はファイル名を表す文字列と解釈しない
set isfname-=\=
" 最後の行に改行がないファイルをそのまま扱う
set nofixeol
" mapleaderの設定
let mapleader = " "



nnoremap * *zz
nnoremap # #zz
nnoremap n nzz
nnoremap N Nzz
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>
nnoremap <Leader><CR> V:!sh<CR>
nnoremap * *Nzz
nnoremap g* g*Nzz
nnoremap # *NNzz
nnoremap g# g*NNzz

inoremap <C-c> <ESC>
inoremap <C-b> <Left>
inoremap <C-f> <Right>

cnoremap <C-a> <C-b>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

vnoremap <Leader><CR> :!sh<CR>

