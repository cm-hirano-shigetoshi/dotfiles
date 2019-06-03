function! Clipboard()
    let file = $HOME . "/clip"
    let lines = split(@", "\n")
    call writefile(lines, file)
    let ret = system("cat " . file . " | perl -0pe 's/^([^\n]+)\n+$/$1/' | pbcopy")
endfunction
nnoremap <silent> <Space>y :call Clipboard()<CR>
