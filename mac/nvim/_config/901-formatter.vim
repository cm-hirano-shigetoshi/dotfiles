function! Fmt()
    if &filetype == 'python'
        let l:pos = winsaveview()
        execute ':%!isort -q - | black -q -'
        call winrestview(l:pos)
    else
        call CocAction('format')
    endif
endfunction

nnoremap <silent> mf :<C-u>call Fmt()<CR>
