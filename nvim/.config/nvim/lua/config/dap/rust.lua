local M = {}

function M.setup()
    local dap = require("dap")

    cmd = vim.env.RUSTLLDB_PATH or "/home/jamie/.vscode/extensions/vadimcn.vscode-lldb-1.7.0/adapter/codelldb"
    dap.adapters.codelldb = function(on_adapter)
        -- This asks the system for a free port
        local tcp = vim.loop.new_tcp()
        tcp:bind('127.0.0.1', 0)
        local port = tcp:getsockname().port
        tcp:shutdown()
        tcp:close()

        -- Start codelldb with the port
        local stdout = vim.loop.new_pipe(false)
        local stderr = vim.loop.new_pipe(false)
        local opts = {
            stdio = { nil, stdout, stderr },
            args = { '--port', tostring(port) },
        }
        local handle
        local pid_or_err
        handle, pid_or_err = vim.loop.spawn(cmd, opts, function(code)
            stdout:close()
            stderr:close()
            handle:close()
            if code ~= 0 then
                print("codelldb exited with code", code)
            end
        end)
        if not handle then
            vim.notify("Error running codelldb: " .. tostring(pid_or_err), vim.log.levels.ERROR)
            stdout:close()
            stderr:close()
            return
        end
        vim.notify('codelldb started. pid=' .. pid_or_err)
        stderr:read_start(function(err, chunk)
            assert(not err, err)
            if chunk then
                vim.schedule(function()
                    require("dap.repl").append(chunk)
                end)
            end
        end)

        local adapter = {
            type = 'server',
            host = '127.0.0.1',
            port = port
        }
        -- 💀
        -- Wait for codelldb to get ready and start listening before telling nvim-dap to connect
        -- If you get connect errors, try to increase 500 to a higher value, or check the stderr (Open the REPL)
        vim.defer_fn(function() on_adapter(adapter) end, 500)
    end

    dap.configurations.rust = {
        {
            type = "codelldb",
            request = "launch",
            name = "lldb",
            args = function()
                local value = vim.fn.input('test file: ', "", "file")
                return { value }
            end,
            program = function()
                local metadata_json = vim.fn.system("cargo metadata --format-version 1 --no-deps")
                local metadata = vim.fn.json_decode(metadata_json)
                local target_name = metadata.packages[1].targets[1].name
                local target_dir = metadata.target_directory
                return target_dir .. "/debug/" .. target_name
            end,
        },
    }

    local api = vim.api
    local keymap_restore = {}
    dap.listeners.after['event_initialized']['me'] = function()
        for _, buf in pairs(api.nvim_list_bufs()) do
            local keymaps = api.nvim_buf_get_keymap(buf, 'n')
            for _, keymap in pairs(keymaps) do
                if keymap.lhs == "K" then
                    table.insert(keymap_restore, keymap)
                    api.nvim_buf_del_keymap(buf, 'n', 'K')
                end
            end
        end
        api.nvim_set_keymap(
            'n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
    end

    dap.listeners.after['event_terminated']['me'] = function()
        for _, keymap in pairs(keymap_restore) do
            api.nvim_buf_set_keymap(
                keymap.buffer,
                keymap.mode,
                keymap.lhs,
                keymap.rhs,
                { silent = keymap.silent == 1 }
            )
        end
        keymap_restore = {}
    end

end

return M
