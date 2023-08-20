local builtin = require('telescope.builtin')
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
}
vim.keymap.set('n', '<leader>;f', builtin.find_files, { desc = 'find files' })
vim.keymap.set('n', '<leader>;s', builtin.grep_string, { desc = 'Project Search' })
vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = 'Project Grep' })
vim.keymap.set("n", "<leader>h", builtin.help_tags, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>;d', builtin.diagnostics, { desc = 'Project Diagnostics' })
vim.keymap.set("n", "<leader>b", builtin.buffers, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set("n", "<leader>P", vim.cmd.Telescope, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

require('telescope').load_extension('fzf')