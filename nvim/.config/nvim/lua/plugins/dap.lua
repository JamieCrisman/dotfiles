return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'nvim-neotest/nvim-nio',
        'rcarriga/nvim-dap-ui',
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',
        {
            "theHamsta/nvim-dap-virtual-text",
            opts = {},
        },
        'leoluz/nvim-dap-go',
    },
    lazy = true,
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        require('mason-nvim-dap').setup {
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_setup = true,

            -- You can provide additional configuration to the handlers,
            -- see mason-nvim-dap README for more information
            handlers = {},

            -- You'll need to check that you have the required things installed
            -- online, please don't ask me how to install them :)
            ensure_installed = {
                -- Update this to ensure that you have the debuggers for the langs you want
                'delve',
                'codelldb',
            },
        }

        -- Basic debugging keymaps, feel free to change to your liking!
        vim.keymap.set('n', '<F4>', dap.continue)
        vim.keymap.set('n', '<F3>', dap.step_into)
        vim.keymap.set('n', '<F2>', dap.step_over)
        vim.keymap.set('n', '<F1>', dap.step_out)
        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
        -- vim.keymap.set('n', '<leader>B', function()
        --     dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        -- end)

        -- Dap UI setup
        -- For more information, see |:help nvim-dap-ui|
        dapui.setup {
            -- Set icons to characters that are more likely to work in every terminal.
            --    Feel free to remove or use ones that you like more! :)
            --    Don't feel like these are good choices.
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            controls = {
                icons = {
                    pause = '⏸',
                    play = '▶',
                    step_into = '⏎',
                    step_over = '⏭',
                    step_out = '⏮',
                    step_back = 'b',
                    run_last = '▶▶',
                    terminate = '⏹',
                },
            },
        }
        -- toggle to see last session result. Without this ,you can't see session output in case of unhandled exception.
        vim.keymap.set("n", "<F8>", dapui.toggle)

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close
        dap.configurations.zig = {
            {
                name = "debug",
                type = "codelldb",
                request = "launch",
                preLaunchTask = "zig build",
                program = function()
                    local paths = vim.split(vim.fn.glob(vim.fn.getcwd() .. '/zig-out/bin/*'), '\n')
                    if #paths == 1 then
                        return paths[1]
                    end
                    return vim.fn.input("path to executable: ", vim.fn.getcwd() .. '/zig-out/bin/', 'file')
                end,
                cwd = "${workspaceFolder}",
                stopAtBeginningOfMainSubprogram = false,
            },
        }
        local defaultcodelldb = dap.adapters.codelldb
        dap.adapters.codelldb = function(cb, config)
            if config.preLaunchTask then vim.fn.system(config.preLaunchTask) end
            cb(defaultcodelldb)
        end

        -- Install golang specific config
        require('dap-go').setup()
    end,
}
