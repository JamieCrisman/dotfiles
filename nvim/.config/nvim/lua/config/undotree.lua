local M = {}

function M.setup()
  vim.api.nvim_set_keymap("n", "<leader>u", ":UndotreeToggle", { noremap = true, silent = true })
end

return M
