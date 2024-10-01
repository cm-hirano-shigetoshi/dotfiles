function! MigemoKensaku() abort
    let current_cmd = getcmdline()
    if current_cmd =~ '\\j'
        call setcmdline(substitute(current_cmd, '\\j', '', 'g'))
        return "\<Plug>(kensaku-search-replace)"
    else
        return ""
    fi
endfunction

cnoremap <expr> <CR> MigemoKensaku()."\<CR>"
