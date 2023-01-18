-- -- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        "rebelot/kanagawa.nvim",
        config = function()
            vim.cmd('colorscheme kanagawa')
        end
    }


    use { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    }

    use "p00f/nvim-ts-rainbow"
    use { -- Additional text objects via treesitter
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }
    use "nvim-treesitter/nvim-treesitter-context"
    use "folke/todo-comments.nvim"
    use "simrat39/symbols-outline.nvim"
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use "tpope/vim-commentary"
    use {
        'VonHeikemen/lsp-zero.nvim',
    }

    -- LSP Support
    use { 'neovim/nvim-lspconfig' }
    use { 'williamboman/mason.nvim' }
    use { 'williamboman/mason-lspconfig.nvim' }
    use { "mfussenegger/nvim-dap" }
    use { "jayp0521/mason-nvim-dap.nvim" }
    use { "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" },
        config = function()
            require("dapui").setup()
        end
    }
    use { "theHamsta/nvim-dap-virtual-text",
        requires = { "mfussenegger/nvim-dap" },
        config = function()
            require("nvim-dap-virtual-text").setup()
        end
    }

    use { 'j-hui/fidget.nvim' }
    use { 'simrat39/rust-tools.nvim' }

    -- Autocompletion
    use { 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'saadparwaiz1/cmp_luasnip' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-nvim-lua' }
    use { 'lukas-reineke/cmp-rg' }
    use { 'hrsh7th/cmp-nvim-lsp-signature-help' }
    use { 'hrsh7th/cmp-nvim-lsp-document-symbol' }

    -- Snippets
    use { 'L3MON4D3/LuaSnip' }
    use { 'rafamadriz/friendly-snippets' }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    if is_bootstrap then
        require('packer').sync()
    end
end)
