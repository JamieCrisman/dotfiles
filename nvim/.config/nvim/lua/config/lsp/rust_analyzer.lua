local M = {}

local lsputils = require "config.lsp.utils"

local config = {
  capabilities = lsputils.get_capabilities(),
  on_attach = lsputils.lsp_attach,
  on_init = lsputils.lsp_init,
  on_exit = lsputils.lsp_exit,
  flags = { debounce_text_changes = 150 },
}

function M.setup(installed_server)
  return config
end

return M
