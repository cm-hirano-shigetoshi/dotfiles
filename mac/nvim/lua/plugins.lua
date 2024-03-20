-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use, rocks)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- IDEぽい環境の構築
    use 'neoclide/coc.nvim'
    --Plug 'davidhalter/jedi-vim'

    -- fzf系
    use {
        'junegunn/fzf.vim',
        requires = { 'junegunn/fzf', run = ':call fzf#install()' }
    }
    use 'vijaymarupudi/nvim-fzf'
    --use 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
    use 'cm-hirano-shigetoshi/fzf-grep.lua'

    -- 基本動作の拡張
    use 'easymotion/vim-easymotion'
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use 'mbbill/undotree'

    -- その他
    --use 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

    -- プラグインテスト
    use 'vim-jp/vital.vim'

    -- 自作お試し
    use 'cm-hirano-shigetoshi/fzf-template-nvim-lua'
    --Plug 'cm-hirano-shigetoshi/VimFzfFileSelector'
    --Plug 'cm-hirano-shigetoshi/fzf-file-selector.lua'
    use {
        'cm-hirano-shigetoshi/fzf-file-selector.vim',
        rocks { "luaposix" },
    }
    use 'cm-hirano-shigetoshi/fzf-buffer-searcher.lua'
    use 'cm-hirano-shigetoshi/vim-csvq'
    use 'cm-hirano-shigetoshi/TimeMachine.vim'
end)
