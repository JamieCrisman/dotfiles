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
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use {
        "rebelot/kanagawa.nvim",
        config = function()
            vim.cmd('colorscheme kanagawa')
        end
    }
    use(
        "nvim-treesitter/nvim-treesitter",
        { run = ':TSUpdate' }
    )
    use "p00f/nvim-ts-rainbow"
    use "nvim-treesitter/nvim-treesitter-textobjects"
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
    use({
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        { "mfussenegger/nvim-dap" },
        { "jayp0521/mason-nvim-dap.nvim" },
        { "rcarriga/nvim-dap-ui",
            requires = { "mfussenegger/nvim-dap" },
            config = function()
                require("dapui").setup()
            end
        },
        { "theHamsta/nvim-dap-virtual-text",
            {
                requires = { "mfussenegger/nvim-dap" },
                config = function()
                    require("nvim-dap-virtual-text").setup()
                end
            }
        },

        { 'j-hui/fidget.nvim' },
        { 'simrat39/rust-tools.nvim' },

        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },

        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },
    })
end)
