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

local hererocks_home = os.getenv("HOME") .. "/.local/share/nvim/lazy-rocks/hererocks"
package.path = package.path .. ";" .. hererocks_home .. "/share/lua/5.1/?.lua"
package.path = package.path .. ";" .. hererocks_home .. "/share/lua/5.1/?/init.lua"
package.cpath = package.cpath .. ";" .. hererocks_home .. "/lib/lua/5.1/?.so"

require("lazy").setup({
    -- 日本語化
    'vim-jp/vimdoc-ja',

    -- ベースとなるプラグイン
    'vim-denops/denops.vim',
    'lambdalisue/kensaku.vim',
    'echasnovski/mini.nvim',
    'lunarmodules/luasocket',
    'luaposix/luaposix',

    -- IDEぽい環境の構築
    'neoclide/coc.nvim',

    -- fzf系
    'junegunn/fzf',
    'junegunn/fzf.vim',
    'vijaymarupudi/nvim-fzf',
    'cm-hirano-shigetoshi/fzf-grep.lua',
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
    'cm-hirano-shigetoshi/fzf-file-selector.vim',
    'cm-hirano-shigetoshi/fzf-buffer-searcher.lua',
    'cm-hirano-shigetoshi/vim-csvq',
    'cm-hirano-shigetoshi/TimeMachine.vim'
})
