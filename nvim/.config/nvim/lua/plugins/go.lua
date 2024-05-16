return {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("go").setup({
            lsp_inlay_hints = {
                enable = false,
                style = "inlay",
            },
        })
        vim.api.nvim_set_hl(0, 'goCoverageUncovered', { fg = "#e46876" })
        vim.api.nvim_set_hl(0, 'goCoverageCovered', { fg = "#98bb6c" })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}
