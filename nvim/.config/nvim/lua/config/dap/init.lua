local M = {}

function M.nvim_dap_setup()
    -- nvim-dap-ui
    require("dapui").setup {}
    require("config.dap.rust").setup()
    require("config.dap.go").setup()
    require('dap-go').setup()

    -- nvim-dap
    --vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
    --vim.fn.sign_define("DapStopped", { text = "⭐️", texthl = "", linehl = "", numhl = "" })

end

function M.setup()
    vim.api.nvim_set_keymap('n', '<M-Up>', [[:lua require'dap'.continue()<CR>]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<M-Right>', [[:lua require'dap'.step_over()<CR>]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<M-Down>', [[:lua require'dap'.step_into()<CR>]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<M-Left>', [[:lua require'dap'.step_out()<CR>]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>b', [[:lua require'dap'.toggle_breakpoint()<CR>]],
        { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>sb',
        [[:lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]],
        { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>dl',
        [[:lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>]],
        { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>dr', [[:lua require'dap'.repl.open()<CR>]], { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>dt', [[:lua require'dap-go'.debug_test()<CR>]],
        { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>dc', [[:lua require'dap'.run_to_cursor()<CR>]],
        { noremap = true, silent = true })

    vim.api.nvim_set_keymap('n', '<HOME>', [[:lua require 'dapui'.toggle(1)<CR>]], { noremap = true, silent = true })


    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end


    M.nvim_dap_setup()
end

return M
