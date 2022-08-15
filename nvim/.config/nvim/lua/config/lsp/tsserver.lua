local M = {}

local lsputils = require "config.lsp.utils"

function M.config(installed_server)
  return {
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" },
    capabilities = lsputils.get_capabilities(),
    on_attach = lsputils.lsp_attach,
    on_init = lsputils.lsp_init,
    on_exit = lsputils.lsp_exit,
    settings = {
      documentFormatting = true,
    },
  }
end

function M.setup(installed_server)
  return M.config(installed_server)
end

return M
