return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("todo-comments").setup {
            highlight = {
                keyword = "bg",
            },
        }

        vim.keymap.set("n", "<leader>lt", vim.cmd.TodoTelescope, { noremap = true, silent = true })
    end
}
