digraphs j, 12289  " 、
digraphs j. 12290  " 。
digraphs j! 65281  " ！
digraphs j? 65311  " ？
digraphs j( 65288  " （
digraphs j) 65289  " ）
digraphs j[ 12300  " 「
digraphs j] 12301  " 」

nnoremap - @q
nnoremap <Space><CR> V:!bash<CR>
nnoremap <silent> y* :<C-u>w !pbcopy<CR><CR>
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>
nnoremap fj f<C-k>j
nnoremap Fj F<C-k>j
nnoremap tj t<C-k>j
nnoremap Tj T<C-k>j
onoremap fj f<C-k>j
onoremap Fj F<C-k>j
onoremap tj t<C-k>j
onoremap Tj T<C-k>j
" なぜかうまく動作しないので個別にマッピングしておく
nnoremap <silent> fj? f<C-k>j?
nnoremap <silent> Fj? F<C-k>j?
nnoremap <silent> tj? t<C-k>j?
nnoremap <silent> Tj? T<C-k>j?
onoremap <silent> fj? f<C-k>j?
onoremap <silent> Fj? F<C-k>j?
onoremap <silent> tj? t<C-k>j?
onoremap <silent> Tj? T<C-k>j?

cnoremap <C-a> <C-b>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>

xnoremap <Space><CR> :!bash<CR>

inoremap <C-c> <Esc>
inoremap <Left> <C-g>U<Left>
inoremap <Right> <C-g>U<Right>

" SQL補完機能のprefixをC-cからEscに変更
let g:ftplugin_sql_omni_key = '<Esc>'

" ヤンク文字列をOSのクリップボードに送る
function! ClipboardYank()
  call system('pbcopy', @0)
endfunction
augroup Yank
  autocmd!
  autocmd TextYankPost * if v:event.operator ==# 'y' | call ClipboardYank() | endif
augroup END
