function! Fzf_gf()
    let tmp = @@
    silent normal gvy
    let selected = @@
    let @@ = tmp
    call writefile([selected], "/Users/hirano.shigetoshi/temp")
    let orig_path = execute('pwd')[1:]
    execute('cd ' . system("git rev-parse --show-toplevel"))
    let out = system("~/PublicRepository/fzfer/fzfer.sh /Users/hirano.shigetoshi/dotfiles/vim/fzfer/gf.yml 2>/dev/tty")
    execute("ar " . out)
    execute('cd ' . orig_path)
    redraw!
endfunction
vnoremap <silent> gf :call Fzf_gf()<CR>
