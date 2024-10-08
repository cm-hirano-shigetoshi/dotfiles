require('mini.ai').setup({
    custom_textobjects = {
        ['`'] = { { '```%w*\n.-```', '`[^`\n]+`' }, { '^```%w*\n().-()```$', '^`().-()`$' } },
        ['['] = { { '「.-」', '%b[]' }, '^[%[「]+().-()[%]」]+$' },
        ['('] = { { '（.-）', '%b()' }, '^[%(（]+().-()[%)）]+$' }, -- ')'
        ['<'] = { { '＜.-＞', '%b<>' }, '^[<＜]+().-()[%>＞]+$' },
        ['f'] = { { '[^%w_%.-][%w_%.-]+%b()', '^[%w_%.-]+%b()' }, { '^[^%w_%.-]()()[%w_%.-]+().*()$', '^()[%w_%.-]+().*$' } },
    },
})
