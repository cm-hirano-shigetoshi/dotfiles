function! StringSearcher()
    let out = system("tput cnorm > /dev/tty; ~/PublicRepository/fzfer/fzfer.sh /Users/hirano.shigetoshi/dotfiles/vim/fzfer/git_grep.yml 2>/dev/tty")
    for file in split(out, '\n')
        let file_line = split(file, ':')
        execute('edit +' . file_line[1] . ' ' . file_line[0])
        execute('normal zz')
    endfor
    redraw!
endfunction

function! SearchWord()
    call writefile([''], '/Users/hirano.shigetoshi/temp')
    call StringSearcher()
endfunction
nnoremap <silent> <Space>/ :call SearchWord()<CR>

function! SearchThisWord()
    let selected = expand('<cword>')
    call writefile([selected], '/Users/hirano.shigetoshi/temp')
    call StringSearcher()
endfunction
nnoremap <silent> <Space>* :<C-u>call SearchThisWord()<CR>

function! SearchSelectedWord()
    let tmp = @@
    silent normal gvy
    let selected = @@
    let @@ = tmp
    call writefile([selected], '/Users/hirano.shigetoshi/temp')
    call StringSearcher()
endfunction
vnoremap <silent> <Space>* :<C-u>call SearchSelectedWord()<CR>

