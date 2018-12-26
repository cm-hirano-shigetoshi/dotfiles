scriptencoding utf-8
if exists('g:load_template_plugin_d2l')
    finish
endif
let g:load_template_plugin_d2l = 1

let s:save_cpo = &cpo
set cpo&vim

nnoremap <silent> <Plug>(hoge) :<C-u>call template_plugin_d2l#Do()<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
