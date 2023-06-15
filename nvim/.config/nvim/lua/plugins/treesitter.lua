return {
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            "nvim-treesitter/nvim-treesitter-context",
            "p00f/nvim-ts-rainbow",
        },
        lazy = true,
        build = ":TSUpdate",
        config = function()
            require 'nvim-treesitter.configs'.setup {
                -- A list of parser names, or "all"
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

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,

                ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
                -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                rainbow = {
                    enable = true,
                    max_file_lines = 8000,
                    colors = {
                        "#E06C75",
                        "#E5C07B",
                        "#98C379",
                        "#56B6C2",
                        "#61AFEF",
                        "#C678DD",
                        "#E06C75",
                        -- "#FF4F69",
                        -- "#c45d9f",
                        -- "#EE6A7C",
                        -- "#FFA7A5",
                        -- "#FFE07E",
                        -- "#FFE7D6",
                        -- "#72DCBB",
                    },
                },

                indent = {
                    enable = true,
                },
                autopairs = { enable = true },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                    },
                },
            }

            require("treesitter-context").setup {}
        end
    }
}
