require("base.remap")
require("base.setup")

local augroup = vim.api.nvim_create_augroup
local piokaGroup = augroup('pioka', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    group = piokaGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
--vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.cmd([[:command WQ wq]])
vim.cmd([[:command Wq wq]])
vim.cmd([[:command W w]])
vim.cmd([[:command Q q]])
