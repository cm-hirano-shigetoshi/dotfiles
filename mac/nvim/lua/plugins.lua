local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- 日本語化
    'vim-jp/vimdoc-ja',

    -- ベースとなるプラグイン
    'vim-denops/denops.vim',
    'lambdalisue/kensaku.vim',
    'echasnovski/mini.nvim',

    -- IDEぽい環境の構築
    'neoclide/coc.nvim',

    -- fzf系
    'junegunn/fzf',
    'junegunn/fzf.vim',
    'vijaymarupudi/nvim-fzf',
    {
        'cm-hirano-shigetoshi/fzf-grep.lua',
        build = '/Users/hirano.shigetoshi/.local/share/mise/shims/luarocks install luasocket'
    },
    'yuki-yano/fzf-preview.vim',

    -- 基本動作の拡張
    'easymotion/vim-easymotion',
    'tpope/vim-repeat',
    'tpope/vim-surround',
    'mbbill/undotree',
    'vim-scripts/camelcasemotion',
    'lambdalisue/kensaku-search.vim',

    -- 自作お試し
    'cm-hirano-shigetoshi/fzf-template-nvim-lua',
    {
        'cm-hirano-shigetoshi/fzf-file-selector.vim',
        build = '/Users/hirano.shigetoshi/.local/share/mise/shims/luarocks install posix'
    },
    'cm-hirano-shigetoshi/fzf-buffer-searcher.lua',
    'cm-hirano-shigetoshi/vim-csvq',
    'cm-hirano-shigetoshi/TimeMachine.vim'
})
