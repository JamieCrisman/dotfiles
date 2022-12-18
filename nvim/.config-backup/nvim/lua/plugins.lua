local M = {}

function M.setup()
  local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
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
    use "wbthomason/packer.nvim" -- Package manager
    use { "ckipp01/stylua-nvim", run = "cargo install stylua" }
    use "tpope/vim-fugitive" -- Git commands in nvim
    --use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
    use "numToStr/Comment.nvim" -- "gc" to comment visual regions/lines
    use {
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons", -- optional, for file icon
      },
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
    use "mjlbach/onedark.nvim" -- Theme inspired by Atom
    use "rebelot/kanagawa.nvim"
    use "nvim-lualine/lualine.nvim" -- Fancier statusline
    use "nvim-lua/popup.nvim"

    -- Add indentation guides even on blank lines
    use "lukas-reineke/indent-blankline.nvim"

    -- Add git related info in the signs columns and popups
    use { "lewis6991/gitsigns.nvim" }
    use { "nvim-lua/plenary.nvim" }

    -- Highlight, edit, and navigate code using a fast incremental parsing library
    use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
    -- Additional textobjects for treesitter
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "nvim-treesitter/nvim-treesitter-context"

    use { "williamboman/nvim-lsp-installer" }
    use { "jose-elias-alvarez/null-ls.nvim" }
    use {
      "ray-x/lsp_signature.nvim",
    }
    use {
      "neovim/nvim-lspconfig",
    }
    use {
      "simrat39/rust-tools.nvim",
    }
    use "folke/neodev.nvim"
    use "hrsh7th/nvim-cmp" -- Autocompletion plugin
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lsp-signature-help"
    use "saadparwaiz1/cmp_luasnip"
    use "lukas-reineke/cmp-rg"
    use { "tzachar/cmp-fuzzy-buffer", requires = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" } }
    use {
      "L3MON4D3/LuaSnip",
      requires = { "onsails/lspkind-nvim" },
      config = function()
        require("lspkind").init()
        require("luasnip").setup {
          -- see: https://github.com/L3MON4D3/LuaSnip/issues/525
          region_check_events = "CursorHold,InsertLeave,InsertEnter",
          delete_check_events = "TextChanged,InsertEnter",
        }
      end,
    }
    use "easymotion/vim-easymotion"
    -- dap
    use "mfussenegger/nvim-dap"
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use "leoluz/nvim-dap-go"
    use {
      "theHamsta/nvim-dap-virtual-text",
    }
    use "nvim-telescope/telescope-dap.nvim"

    use { "stevearc/dressing.nvim" }
    use "mg979/vim-visual-multi" -- :help visual-multi
    use { -- smooth scroller
      "karb94/neoscroll.nvim",
    }
    use "tpope/vim-commentary"
    use "windwp/nvim-autopairs"
    use "folke/todo-comments.nvim"
    use "ThePrimeagen/harpoon"
    use { "akinsho/toggleterm.nvim" }
    use "lukas-reineke/lsp-format.nvim"
    use {
      "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig",
    }
    use "mbbill/undotree"
    use "p00f/nvim-ts-rainbow"
    use { "rose-pine/neovim", as = "rose-pine", tag = "v1.*" }
    use { "mhanberg/elixir.nvim", requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" } }
    use "simrat39/symbols-outline.nvim"
    use {
      "Pocco81/true-zen.nvim",
      config = function()
        require("true-zen").setup {
          -- your config goes here
          -- or just leave it empty :)
        }
      end,
    }
    use 'ThePrimeagen/vim-be-good'
  end

  pcall(require, "packer_compiled")
  require("packer").init(conf)
  require("packer").startup(setup)
  -- local t = tonumber(os.date("%H"))
  -- if t >= 7 and t "%H" < 16 then
  --  require("nightfox").setup {}
  --  vim.cmd "colorscheme nightfox"
  -- else
  --  require("kanagawa").setup {}
  --  vim.cmd "colorscheme kanagawa"
  --end
  -- require("luasnip").setup {
  --   region_check_events = "CursorHold,InsertLeave,InsertEnter",
  --   delete_check_events = "TextChanged,InsertEnter",
  -- }
  require "configs"

  require("config.lsp.init").setup()
  require("config.cmp").setup()
  require("config.telescoper").setup()
  require("config.neoscroll").setup()
  require("config.tree").setup()
  require("config.dap").setup()
  require("config.todo").setup()
  require("config.undotree").setup()
  require("config.harpoon").setup()
  require("rust-tools").setup {}
  require("rust-tools.runnables").runnables()
  require("symbols-outline").setup()
end

return M
