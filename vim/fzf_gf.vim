function! Fzf_gf()
    if glob('<cfile>') != ''
        execute("find " . expand('<cfile>'))
    else
        let file_name = expand('<cfile>')
        call writefile([file_name], "/Users/hirano.shigetoshi/temp")
        let out = system("tput cnorm > /dev/tty; fzfyml run /Users/hirano.shigetoshi/dotfiles/vim/fzfyml/gf.yml 2>/dev/tty")
        if out == '(create)'
            let pos = strridx(file_name, "/")
            call system("mkdir -p '" . file_name[:pos] . "'")
            execute("e " . file_name)
        else
            execute("ar " . out)
        endif
        redraw!
    endif
endfunction
nnoremap <silent> gf :call Fzf_gf()<CR>
