" カラースキーム
colorscheme vim
" マウスを無効に
set mouse=
" 現在のバッファに変更があっても他のバッファに移れる
set hidden
" 行番号を表示
set number
" 折り返ししない
set nowrap
" スワップファイルを作成しない
set noswapfile
" タブなどに対して薄く文字を表示する
set list
" 表示する文字の設定
set listchars=tab:>\ ,trail:_,nbsp:%
" タブの表示幅
set tabstop=4
" タブの代わりに空白を挿入
set expandtab
" タブ代わりの空白の数
set shiftwidth=4
" タブインデント行を<<した時に空白にしない
set preserveindent
" タブインデント行の次の行もタブにする
set copyindent
" 最後の行に改行がないファイルをそのまま扱う
set nofixeol
" undoファイルを所定の場所に保存
set undofile
set undodir=$HOME/.local/share/nvim/undo
" 外部からの変更を勝手にロードしない
set noautoread
" 検索をsmartcaseにする
set ignorecase
" 相対行数
set relativenumber
