return {
    "folke/zen-mode.nvim",
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        window = {
            width = 100,
            options = {
                signcolumn = "no",
                number = false,
                cursorcolumn = false,
                relativenumber = false, -- disable relative numbers
                -- cursorline = false, -- disable cursorline
                -- cursorcolumn = false, -- disable cursor column
                -- foldcolumn = "0", -- disable fold column
                -- list = false, -- disable whitespace characters
                colorcolumn = "0",
            }
        },
        plugins = {
            options = {
                ruler = false
            },
            gitsigns = {
                enabled = true,
            },
            tmux = {
                enabled = true,
            },
            kitty = {
                enabled = true,
                font = "+2", -- font size increment
            },
        }
    }
}
