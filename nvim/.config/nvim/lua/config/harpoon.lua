local M = {}

function M.setup()
	local silent = { silent = true }
	require("harpoon").setup({})

	-- Terminal commands
	-- ueoa is first through fourth finger left hand home row.
	-- This just means I can crush, with opposite hand, the 4 terminal positions
	--
	-- These functions are stored in harpoon.  A plugn that I am developing
	vim.api.nvim_set_keymap("n", "<leader>a", [[:lua require("harpoon.mark").add_file()<CR>]], silent)
	vim.api.nvim_set_keymap("n", "<C-e>", [[:lua require("harpoon.ui").toggle_quick_menu()<CR>]], silent)
	vim.api.nvim_set_keymap("n", "<leader>tc", [[:lua require("harpoon.cmd-ui").toggle_quick_menu()<CR>]], silent)
	vim.api.nvim_set_keymap("n", "<leader>h", [[:lua require("harpoon.ui").nav_file(1)<CR>]], silent)
	vim.api.nvim_set_keymap("n", "<leader>j", [[:lua require("harpoon.ui").nav_file(2)<CR>]], silent)
	vim.api.nvim_set_keymap("n", "<leader>k", [[:lua require("harpoon.ui").nav_file(3)<CR>]], silent)
	vim.api.nvim_set_keymap("n", "<leader>l", [[:lua require("harpoon.ui").nav_file(4)<CR>]], silent)
end

return M
