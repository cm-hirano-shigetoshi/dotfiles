function! Clipboard()
    let lines = split(@", "\n")
    if len(lines) == 1
        let text = lines[0]
    else
        let text = @"
    endif
    call system("echo -n '" . text . "' | pbcopy")
endfunction
nnoremap <silent> <Space>y :call Clipboard()<CR>
