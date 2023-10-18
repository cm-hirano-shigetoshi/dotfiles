-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- IDEぽい環境の構築
    use 'neoclide/coc.nvim'
    --Plug 'davidhalter/jedi-vim'
    use {
        'junegunn/fzf.vim',
        requires = { 'junegunn/fzf', run = ':call fzf#install()' }
    }
    use 'vijaymarupudi/nvim-fzf'
    --use 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }

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
    --Plug 'cm-hirano-shigetoshi/VimFzfFileSelector'
    --Plug 'cm-hirano-shigetoshi/fzf-file-selector.lua'
    use 'cm-hirano-shigetoshi/fzf-file-selector.vim'
    use 'cm-hirano-shigetoshi/fzf-grep.vim'
    use 'cm-hirano-shigetoshi/fzf-buffer-searcher.lua'
    use 'cm-hirano-shigetoshi/vim-csvq'
end)
