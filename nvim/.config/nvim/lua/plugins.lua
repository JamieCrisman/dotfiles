local M = {}

function M.setup()
	local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
	end

	vim.cmd [[
	augroup Packer
	autocmd!
	autocmd BufWritePost plugins.lua PackerCompile
	augroup end
	]]


	local conf = {
		compile_path = vim.fn.stdpath "config" .. "/plugin/packer_compiled.lua",
		display = {
			open_fn = function()
				return require("packer.util").float { border = "rounded" }
			end,
		},
	}

	local setup = function(use)
		use 'wbthomason/packer.nvim' -- Package manager
		use({ "ckipp01/stylua-nvim", run = "cargo install stylua" })
		use 'tpope/vim-fugitive' -- Git commands in nvim
		--use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
		use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
		use {
			'kyazdani42/nvim-tree.lua',
			requires = {
				'kyazdani42/nvim-web-devicons', -- optional, for file icon
			}
		}
		--  use 'ludovicchabant/vim-gutentags' -- Automatic tags management
		-- UI to select things (files, grep results, open buffers...)
		use {
			"nvim-telescope/telescope.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope-fzf-native.nvim",
			},
		}
		use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
		use 'mjlbach/onedark.nvim' -- Theme inspired by Atom
		use 'nvim-lualine/lualine.nvim' -- Fancier statusline
		use 'nvim-lua/popup.nvim'

		-- Add indentation guides even on blank lines
		use 'lukas-reineke/indent-blankline.nvim'

		-- Add git related info in the signs columns and popups
		use { 'lewis6991/gitsigns.nvim' }
		use { 'nvim-lua/plenary.nvim' }

		-- Highlight, edit, and navigate code using a fast incremental parsing library
		use 'nvim-treesitter/nvim-treesitter'
		-- Additional textobjects for treesitter
		use 'nvim-treesitter/nvim-treesitter-textobjects'

		use { "williamboman/nvim-lsp-installer" }
		use { "jose-elias-alvarez/null-ls.nvim" }
		use {
			"ray-x/lsp_signature.nvim",
		}
		use {
			"neovim/nvim-lspconfig"
		}
		use {
			"simrat39/rust-tools.nvim",
		}
		use { "folke/lua-dev.nvim", event = "VimEnter" }
		use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
		use 'hrsh7th/cmp-nvim-lsp'
		use 'saadparwaiz1/cmp_luasnip'
		use 'L3MON4D3/LuaSnip' -- Snippets plugin
		use 'luochen1990/rainbow'
		use 'easymotion/vim-easymotion'
		-- dap
		use("mfussenegger/nvim-dap")
		use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
		use 'leoluz/nvim-dap-go'
		use {
			"theHamsta/nvim-dap-virtual-text"
		}
		use 'nvim-telescope/telescope-dap.nvim'


		use { 'stevearc/dressing.nvim' }
		use 'mg979/vim-visual-multi' -- :help visual-multi
		use { -- smooth scroller
			'karb94/neoscroll.nvim',
		}
		use 'windwp/nvim-autopairs'
		use 'folke/todo-comments.nvim'
		use 'ThePrimeagen/harpoon'
		use { "akinsho/toggleterm.nvim" }
	end

	pcall(require, "packer_compiled")
	require("packer").init(conf)
	require('packer').startup(setup)
	require("configs")

	require("config.cmp").setup()
	require("config.lsp").setup()
	require("config.telescoper").setup()
	require("config.neoscroll").setup()
	require("config.tree").setup()
	require("config.dap").setup()
	require('rust-tools').setup({})
	require('rust-tools.runnables').runnables()

end

return M
