function! FzfGitGrep()
    let tmp = @@
    silent normal gvy
    let selected = @@
    let @@ = tmp
    call writefile([selected], '/Users/hirano.shigetoshi/temp')
    let orig_path = execute('pwd')[1:]
    execute('cd ' . system("git rev-parse --show-toplevel"))
    let out = system("~/PublicRepository/fzfer/fzfer.sh /Users/hirano.shigetoshi/dotfiles/vim/fzfer/git_grep.yml 2>/dev/tty")
    for file in split(out, '\n')
        let file_line = split(file, ':')
        execute('edit +' . file_line[1] . ' ' . file_line[0])
    endfor
    execute('cd ' . orig_path)
    redraw!
endfunction
vnoremap <silent> <Space>* :call FzfGitGrep()<CR>
nnoremap <silent> <Space>* viw:call FzfGitGrep()<CR>

function! FzfGitGrepEmpty()
    call writefile([''], '/Users/hirano.shigetoshi/temp')
    let out = system("~/PublicRepository/fzfer/fzfer.sh /Users/hirano.shigetoshi/dotfiles/vim/fzfer/git_grep.yml 2>/dev/tty")
    let orig_path = execute('pwd')[1:]
    execute('cd ' . system("git rev-parse --show-toplevel"))
    for file in split(out, '\n')
        let file_line = split(file, ':')
        execute('edit +' . file_line[1] . ' ' . file_line[0])
    endfor
    execute('cd ' . orig_path)
    redraw!
endfunction
nnoremap <silent> <Space>/ :call FzfGitGrepEmpty()<CR>
