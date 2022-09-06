local M = {}

local lsputils = require "config.lsp.utils"

function M.config(installed_server)
  return {
    -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
    experimentalPostfixCompletions = true,
    analyses = { unusedparams = true, nilness = true, unusedvariable = true, shadow = true },
    codelenses = { generate = true, gc_details = true, test = true, tidy = true, upgrade_dependency = true },
    usePlaceholders = true,
    completeUnimported = true,
    staticcheck = true,
    matcher = "fuzzy",
    experimentalDiagnosticsDelay = "200ms",
    symbolMatcher = "fuzzy",
    gofumpt = true,
    -- buildFlags = { "-tags", "integration" },
    capabilities = lsputils.get_capabilities(),
    on_attach = lsputils.lsp_attach,
    on_init = lsputils.lsp_init,
    on_exit = lsputils.lsp_exit,
    flags = { debounce_text_changes = 150 },
    settings = {
      gopls = {
        buildFlags = { "-tags=integration" },
        -- it's not clear to me where this is supposed to go lol
        staticcheck = true,
        gofumpt = true,
        matcher = "fuzzy",
        experimentalDiagnosticsDelay = "200ms",
        symbolMatcher = "fuzzy",
        usePlaceholders = true,
        completeUnimported = true,
        experimentalPostfixCompletions = true,
        analyses = { unusedparams = true, nilness = true, unusedvariable = true },
        codelenses = { generate = true, gc_details = true, test = true, tidy = true, upgrade_dependency = true },
      },
    },
  }
end

function M.setup(installed_server)
  return M.config(installed_server)
end

return M
