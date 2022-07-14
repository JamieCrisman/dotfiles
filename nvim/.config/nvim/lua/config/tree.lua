local M = {}

function M.setup()
	vim.g.nvim_tree_respect_buf_cwd = 1

	-- different type of tree
	-- require("nvim-tree").setup {
	-- 	update_cwd = true,
	-- 	update_focused_file = {
	-- 		enable = true,
	-- 		update_cwd = true,
	-- 	},
	-- }

	require("nvim-treesitter.configs").setup {
		ensure_installed = {
			"html",
			"lua",
			"rust",
			"go",
			"javascript",
			"markdown",
			"css",
			"tsx",
			"regex",
			"dockerfile",
			"gomod",
			"gowork",
			"json",
			"nix",
			"toml",
			"yaml",
			"zig",
			"proto",
		},
		highlight = {
			enable = true, -- false will disable the whole extension
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn",
				node_incremental = "grn",
				scope_incremental = "grc",
				node_decremental = "grm",
			},
		},
		indent = {
			enable = true,
		},
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
end

return M
