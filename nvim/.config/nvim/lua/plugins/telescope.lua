return {
    -- Fuzzy Finder (files, lsp, etc)
    { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },
},
    config = function()
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
            vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'search files' })
            vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'search word' })
            vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'search Grep' })
            vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = 'search help', noremap = true, silent = true })
            vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Project Diagnostics' })
            vim.keymap.set("n", "<leader><space>", builtin.buffers, { noremap = true, silent = true })
            vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
            vim.keymap.set("n", "<leader>P", vim.cmd.Telescope, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})

            require('telescope').load_extension('fzf')
    end
},
}
