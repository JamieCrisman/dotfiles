return {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },

    -- https://github.com/m4xshen/hardtime.nvim/blob/main/lua/hardtime/config.lua
    config = function()
        require("hardtime").setup({
            -- enabled = os.getenv("NVIM_HARDTIME") == "true",
            enabled = false,
            disabled_filetypes = {
                "NvimTree",
                "TelescopePrompt",
                "aerial",
                "alpha",
                "checkhealth",
                "dapui*",
                "Diffview*",
                "Dressing*",
                "help",
                "httpResult",
                "lazy",
                "Neogit*",
                "mason",
                "neotest-summary",
                "minifiles",
                "neo-tree*",
                "netrw",
                "noice",
                "notify",
                "prompt",
                "qf",
                "oil",
                "undotree",
                "Trouble",
                "fugitive",
                "harpoon"
            }

        })
    end
}
