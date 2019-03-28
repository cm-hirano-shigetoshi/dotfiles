function! Fzf_gf()
    if expand(glob('<cfile>')) != ''
        execute("normal gf")
    else
        let file_name = expand('<cfile>')
        call writefile([file_name], "/Users/hirano.shigetoshi/temp")
        let out = system("tput cnorm > /dev/tty; ~/PublicRepository/fzfer/fzfer.sh /Users/hirano.shigetoshi/dotfiles/vim/fzfer/gf.yml 2>/dev/tty")
        execute("ar " . out)
        redraw!
    endif
endfunction
nnoremap <silent> gf :call Fzf_gf()<CR>
