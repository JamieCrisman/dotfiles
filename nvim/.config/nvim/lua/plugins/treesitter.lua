return {
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
        },
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "c",
                "lua",
                "rust",
                "go",
                "gomod",
                "javascript",
                "typescript",
                "css",
                "nix",
                "toml",
                "yaml",
                "hcl",
                "proto",
                "elixir",
                "terraform",
                "zig"
            },
            auto_install = true,
            highlight = {
                enable = true,
            },
            indent = { enable = true }
        },
        config = function(_, opts)
            require('nvim-treesitter.install').prefer_git = true
            require 'nvim-treesitter.configs'.setup(opts)
            require("treesitter-context").setup {
                max_lines = 3
            }
        end
    }
}
