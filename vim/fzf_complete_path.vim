function! Fzf_complete_path()
    let file_path = expand('<cfile>')
    let pos = strridx(file_path, '/')
    if pos == len(file_path)-1
        let dir = file_path[:pos-1]
        let query = ""
    else
        if isdirectory(expand(file_path))
            let dir = file_path
            let query = ""
        else
            if pos == 0
                let dir = "/"
                let query = file_path[1:]
            else
                let dir = file_path[:pos-1]
                let query = file_path[pos+1:]
            endif
        endif
    endif
    call writefile([dir, expand(dir), query], "/Users/hirano.shigetoshi/temp")
    let out = system("tput cnorm > /dev/tty; fzfyml run /Users/hirano.shigetoshi/dotfiles/vim/fzfyml/complete_path.yml 2>/dev/tty")
    call writefile([out], "/Users/hirano.shigetoshi/temp")
    if len(out) > 0
        if dir == "/"
            let selected_path = "/" . out
        else
            let selected_path = dir . "/" . out
        endif
        call writefile([selected_path], "/Users/hirano.shigetoshi/temp")
        let move_left = len(file_path) - 1
        if move_left > 0
            execute('normal v' . move_left . 'hd')
        else
            execute('normal x')
        endif
        execute('normal a' . selected_path)
    endif
    redraw!
endfunction
inoremap <silent> <S-Tab> <Esc>:call Fzf_complete_path()<CR>a

