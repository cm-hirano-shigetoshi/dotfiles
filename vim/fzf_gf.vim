function! Fzf_gf()
    let file_name = expand('<cfile>')
    call writefile([file_name], "/Users/hirano.shigetoshi/temp")
    let out = system("~/PublicRepository/fzfer/fzfer.sh /Users/hirano.shigetoshi/dotfiles/vim/fzfer/gf.yml 2>/dev/tty")
    execute("ar " . out)
    redraw!
endfunction
nnoremap <silent> gf :call Fzf_gf()<CR>
