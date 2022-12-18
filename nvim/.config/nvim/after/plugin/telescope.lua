local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>ps', builtin.grep_string, { desc = 'Project Search' })
vim.keymap.set('n', '<leader>pg', builtin.live_grep, { desc = 'Project Grep' })
vim.keymap.set("n", "<leader>ph", builtin.help_tags, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>pd', builtin.diagnostics, { desc = 'Project Diagnostics' })
vim.keymap.set("n","<leader>b", builtin.buffers, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set("n", "<leader>pp", vim.cmd.Telescope, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })
pcall(require('telescope').load_extension, 'fzf')
