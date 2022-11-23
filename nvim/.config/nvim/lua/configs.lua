vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.errorbells = false

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = "a"

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.cmdheight = 1

--Decrease update time
vim.o.updatetime = 200
vim.wo.signcolumn = "yes"

--Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme kanagawa]]

--Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noinsert,noselect"
vim.g.completion_enable_auto_popup = 1

vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { "help", "packer" }
vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_show_trailing_blankline_indent = false

vim.api.nvim_set_keymap("n", "<leader>y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>Y", '"+Y', {})

-- Diagnostic keymaps
vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>ev", "<cmd>:Ex ~/.config/nvim<CR>", { noremap = true, silent = true })

-- highlight yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

vim.g.navic_silence = true
vim.o.statusline = "%f %h%w%m%r %{%v:lua.require'nvim-navic'.get_location()%} %=%-14.(%l,%c%V%) %P"

-- local t = tonumber(os.date "%H")
-- if t >= 7 and t < 16 then
--   vim.o.background = "light"
--   require("rose-pine").setup {}
--   vim.cmd "colorscheme rose-pine"
-- else
require("kanagawa").setup {}
vim.cmd "colorscheme kanagawa"
-- end

vim.api.nvim_set_keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
  "n",
  "<leader>s",
  ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  { noremap = true, silent = true }
)

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*.heex", ".exs", ".ex" },
  command = "set filetype=elixir",
})
vim.cmd [[ autocmd FileType elixir setlocal formatprg=mix\ format\ - ]]
vim.cmd [[ autocmd FileType elixir setlocal shiftwidth=2 ]]
vim.cmd [[ autocmd FileType elixir setlocal tabstop=2 ]]
