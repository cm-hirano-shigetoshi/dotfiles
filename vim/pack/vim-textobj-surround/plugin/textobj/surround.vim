if exists('g:loaded_textobj_surround')
  finish
endif

call textobj#user#plugin('quoted', {
\      '-': {
\        '*sfile*': expand('<sfile>:p'),
\        'select-a': 'aS',  '*select-a-function*': 'textobj#surround#select_a',
\        'select-i': 'iS',  '*select-i-function*': 'textobj#surround#select_i'
\      }
\    })

let g:loaded_textobj_surround = 1

