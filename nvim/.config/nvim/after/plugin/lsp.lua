local lsp = require("lsp-zero")

lsp.preset('recommended')

lsp.ensure_installed({
    'lua_ls',
    'rust_analyzer',
    'gopls',
    'elixirls',
    'golangci_lint_ls',
})

lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            },
            telemetry = { enable = false }
        },
    }
})

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

local cmp = require('cmp')
local types = require('cmp.types')

local function deprioritize_snippet(entry1, entry2)
    if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then return false end
    if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then return true end
end

local cmp_config = lsp.defaults.cmp_config({
    window = {
        completion = cmp.config.window.bordered()
    },
    sorting = {
        comparators = {
            deprioritize_snippet,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                -- elseif luasnip.expand_or_jumpable() then
                --     luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
                -- elseif luasnip.jumpable(-1) then
                --     luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lsp_document_symbol' },
        { name = 'path',                    limit = 3 },
        { name = 'rg',                      limit = 3 },
        { name = 'nvim_lua' },
        -- { name = 'luasnip' }
    }, {
        { name = 'buffer', limit = 3, keyword_length = 3 },
    })
})

cmp.setup(cmp_config)

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "<leader>D", function() vim.lsp.buf.type_definition() end, opts)
    vim.keymap.set("n", "gI", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<leader>ds', function() require('telescope.builtin').lsp_document_symbols() end,
        { buffer = bufnr, desc = '[D]ocument [S]ymbols' })
    vim.keymap.set('n', '<leader>ws', function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end,
        { buffer = bufnr, desc = '[W]orkspace [S]ymbols' })
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
        { buffer = bufnr, desc = '[W]orkspace [A]dd Folder' })
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
        { buffer = bufnr, desc = '[W]orkspace [R]emove Folder' })
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { buffer = bufnr, desc = '[W]orkspace [L]ist Folders' })
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    end
end)

local rust_lsp = lsp.build_options('rust_analyzer', {
    settings = {
        ["rust-tools"] = {
            lens = { enable = true, },
            check = {}
        }
    }
})
lsp.setup()

-- vim.diagnostic.config({
--     virtual_text = true,
-- })

require('rust-tools').setup({ server = rust_lsp })
