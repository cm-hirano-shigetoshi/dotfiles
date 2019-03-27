function! Fzf_gf()
    let tmp = @@
    silent normal gvy
    let selected = @@ . " "
    let @@ = tmp
    call writefile([selected], "/Users/hirano.shigetoshi/temp")
    let out = system("~/PublicRepository/fzfer/fzfer.sh /Users/hirano.shigetoshi/dotfiles/vim/fzfer/gf.yml 2>/dev/tty")
    execute("ar " . out)
    redraw!
endfunction
vnoremap <silent> gf :call Fzf_gf()<CR>
