local M = {}

function M.setup()
  require("todo-comments").setup {
    highlight = {
      keyword = "bg",
    },
  }

  vim.api.nvim_set_keymap("n", "<leader>lt", "<cmd>TodoTelescope<CR>", { noremap = true, silent = true })
end

return M
