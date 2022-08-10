local M = {}

function M.lsp_diagnostics()
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    underline = false,
    signs = true,
    update_in_insert = false,
    border = "rounded",
  })

  local on_references = vim.lsp.handlers["textDocument/references"]
  vim.lsp.handlers["textDocument/references"] = vim.lsp.with(on_references, { loclist = true, virtual_text = true })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

function M.lsp_config(client, bufnr)
  require("lsp_signature").on_attach {
    bind = true,
    handler_opts = { border = "rounded" },
    floating_window_off_y = -2,
  }

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(...)
  end

  buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<Cmd>lua vim.diagnostic.open_float()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- TODO: change C-k
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>so",
    [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
    opts
  )
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format({async = true})' ]]

  if client.server_capabilities.documentFormatting then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>f", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", opts)
    vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()"
  end
  if client.server_capabilities.documentRangeFormatting then
    vim.api.nvim_buf_set_keymap(bufnr, "v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_exec(
      [[
hi link LspReferenceRead Visual
hi link LspReferenceText Visual
hi link LspReferenceWrite Visual
augroup lsp_document_highlight
  autocmd! * <buffer>
  autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
augroup END
            ]],
      false
    )
  end
end

function M.lsp_init(client, bufnr)
  -- LSP init
end

function M.lsp_exit(client, bufnr)
  -- LSP exit
end

function M.lsp_attach(client, bufnr)
  M.lsp_config(client, bufnr)
  -- M.lsp_highlight(client, bufnr)
  M.lsp_diagnostics()
  require("nvim-navic").attach(client, bufnr)
  require("lsp-format").on_attach(client)
end

function M.get_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  -- for nvim-cmp
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  return capabilities
end

function M.setup_server(server, config)
  local options = {
    on_attach = M.lsp_attach,
    on_exit = M.lsp_exit,
    on_init = M.lsp_init,
    capabilities = M.get_capabilities(),
    flags = { debounce_text_changes = 150 },
  }
  for k, v in pairs(config) do
    options[k] = v
  end

  local lspconfig = require "lspconfig"
  lspconfig[server].setup(vim.tbl_deep_extend("force", options, {}))

  local cfg = lspconfig[server]
  if not (cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1) then
    print(server .. ": cmd not found: " .. vim.inspect(cfg.cmd))
  end
end

return M
