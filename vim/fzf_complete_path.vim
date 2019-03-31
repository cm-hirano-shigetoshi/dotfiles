function! Fzf_complete_path()
    let file_path = expand('<cfile>')
    let pos = strridx(file_path, '/')
    if pos == -1
        call writefile([".", file_path], "/Users/hirano.shigetoshi/temp")
    elseif pos == 0
        call writefile(["/", file_path[1:]], "/Users/hirano.shigetoshi/temp")
    else
        let root_dir = expand(file_path[:pos-1])
        let query = file_path[pos+1:]
        call writefile([root_dir, query], "/Users/hirano.shigetoshi/temp")
    endif
    let out = system("tput cnorm > /dev/tty; ~/PublicRepository/fzfer/fzfer.sh /Users/hirano.shigetoshi/dotfiles/vim/fzfer/complete_path.yml 2>/dev/tty")
    let move_left = len(file_path) - 1
    execute('normal v' . move_left . 'hd')
    execute('normal a' . out)
    redraw!
endfunction
"inoremap <silent> <S-Tab> <Esc>:call Fzf_complete_path()<CR>a

