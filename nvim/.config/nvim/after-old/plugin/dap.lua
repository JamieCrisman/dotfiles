local dap = require("mason-nvim-dap")

-- https://github.com/jay-babu/mason-nvim-dap.nvim
dap.setup({
    ensure_installed = {
        "delve",
        "codelldb",
    },
    automatic_setup = true,
})
