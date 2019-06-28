function! FileHistory()
    let file_name = expand('%')
    call writefile([file_name], "/Users/hirano.shigetoshi/temp")
    let out = system("tput cnorm > /dev/tty; fzfyml run /Users/hirano.shigetoshi/dotfiles/vim/fzfyml/history.yml 2>/dev/tty")
    let out = "git show " . out . ":" . system("git rev-parse --show-prefix " . file_name . " | tr -d '\n'")
    echomsg out
    let lines = split(system(out), '\n')
    execute("normal ggVGd")
    call append(0, lines)
    redraw!
endfunction
