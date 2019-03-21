function! FzfGitGrep()
    let tmp = @@
    silent normal gvy
    let selected = @@
    let @@ = tmp
    call writefile([selected], "/Users/hirano.shigetoshi/temp")
    let out = system("~/PublicRepository/fzfer/fzfer.sh /Users/hirano.shigetoshi/dotfiles/vim/fzfer/git_grep.yml 2>/dev/tty")
    execute("ar " . out)
    redraw!
endfunction
vnoremap <silent> <Space>/ :call FzfGitGrep()<CR>
nnoremap <silent> <Space>/ viw:call FzfGitGrep()<CR>
