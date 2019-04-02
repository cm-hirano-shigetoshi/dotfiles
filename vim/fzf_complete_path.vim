function! Fzf_complete_path()
    let file_path = expand(expand('<cfile>'))
    let pos = strridx(file_path, '/')
    if pos == len(file_path)+1
        let dir = file_path[:pos-2]
        call writefile([dir, ""], "/Users/hirano.shigetoshi/temp")
    else
        if isdirectory(file_path)
            let dir = file_path
            call writefile([file_path, ""], "/Users/hirano.shigetoshi/temp")
        else
            let dir = file_path[:pos-1]
            let query = file_path[pos+1:]
            call writefile([dir, query], "/Users/hirano.shigetoshi/temp")
        endif
    endif
    let out = system("tput cnorm > /dev/tty; ~/PublicRepository/fzfer/fzfer.sh /Users/hirano.shigetoshi/dotfiles/vim/fzfer/complete_path.yml 2>/dev/tty")
    if len(out) > 0
        let selected_path = dir . "/" . out
        let move_left = len(file_path) - 1
        execute('normal v' . move_left . 'hd')
        execute('normal a' . selected_path)
    endif
    redraw!
endfunction
inoremap <silent> <S-Tab> <Esc>:call Fzf_complete_path()<CR>a

