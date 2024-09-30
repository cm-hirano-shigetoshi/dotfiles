require('mini.ai').setup({
    custom_textobjects = {
        ['['] = { { '「.-」', '%b[]' }, '^[%[「]+().-()[%]」]+$' },
        ['('] = { { '（.-）', '%b()' }, '^[%(（]+().-()[%)）]+$' },
        ['<'] = { { '＜.-＞', '%b<>' }, '^[<＜]+().-()[%>＞]+$' },
    },
})
