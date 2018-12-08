scriptencoding utf-8
if exists('g:loaded_jump_to_surround')
    finish
endif
let g:loaded_jump_to_surround = 1

let s:save_cpo = &cpo
set cpo&vim

noremap  <silent>       <Plug>(jump_to_surround#Jump) :<C-u>call jump_to_surround#Jump()<CR>
xnoremap <silent><expr> <Plug>(jump_to_surround#Jump) jump_to_surround#NormalStr()

let &cpo = s:save_cpo
unlet s:save_cpo

