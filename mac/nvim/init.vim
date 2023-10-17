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

lua << EOF
require 'plugins'
EOF

" 各種設定の読み込み
call map(sort(split(globpath(&runtimepath, '_config/*.vim'))), {->[execute('exec "so" v:val')]})

