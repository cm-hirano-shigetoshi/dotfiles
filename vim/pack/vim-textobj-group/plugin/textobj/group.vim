if exists('g:loaded_textobj_group')
  finish
endif

call textobj#user#plugin('group', {
\      '-': {
\        '*sfile*': expand('<sfile>:p'),
\        'select-a': 'a<Space>',  '*select-a-function*': 'textobj#group#select_a',
\        'select-i': 'i<Space>',  '*select-i-function*': 'textobj#group#select_i'
\      }
\    })

let g:loaded_textobj_group = 1

