local M = {}

local lsputils = require "config.lsp.utils"

-- DATA_PATH = vim.fn.stdpath "data"

function M.config(installed_server)
  return {
    library = { vimruntime = true, types = true, plugins = true },
    lspconfig = {
      capabilities = lsputils.get_capabilities(),
      on_attach = lsputils.lsp_attach,
      on_init = lsputils.lsp_init,
      on_exit = lsputils.lsp_exit,
      cmd_env = installed_server._default_options.cmd_env,
      settings = {
        Lua = {
          format = {
            enable = false,
            defaultConfig = {
              indent_style = "space",
              indent_size = "2",
            },
          },
          telemetry = { enable = false },
          runtime = {
            version = "LuaJIT",
            path = vim.split(package.path, ";"),
          },
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
            },
            maxPreload = 100000,
            preloadFileSize = 1000,
          },
        },
      },
    },
  }
end

function M.setup(installed_server)
  local opts = {}
  installed_server:setup(opts)
  require("neodev").setup()

  local lspconfig = require "lspconfig"
  lspconfig.sumneko_lua.setup(M.config(installed_server))
end

return M
