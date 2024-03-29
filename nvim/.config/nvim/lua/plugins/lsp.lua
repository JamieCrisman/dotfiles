return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },
    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'L3MON4D3/LuaSnip',
            { "rafamadriz/friendly-snippets" },
            'saadparwaiz1/cmp_luasnip',
            'lukas-reineke/cmp-rg',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-nvim-lsp-document-symbol'
        },
        config = function()
            -- local types = require('cmp.types')
            --
            -- local function deprioritize_snippet(entry1, entry2)
            --     if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then return false end
            --     if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then return true end
            -- end
            require('lsp-zero.cmp').extend()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = require('lsp-zero.cmp').action()
            require('luasnip.loaders.from_vscode').lazy_load()
            local luasnip = require('luasnip')

            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                -- sorting = {
                --     comparators = {
                --         deprioritize_snippet,
                --         cmp.config.compare.offset,
                --         cmp.config.compare.exact,
                --         cmp.config.compare.score,
                --         cmp.config.compare.recently_used,
                --         cmp.config.compare.locality,
                --         cmp.config.compare.kind,
                --         cmp.config.compare.sort_text,
                --         cmp.config.compare.length,
                --         cmp.config.compare.order,
                --     },
                -- },
                mapping = cmp.mapping.preset.insert {
                    -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-CR>'] = cmp.mapping.complete {},
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
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
                    { name = 'nvim_lsp',                limit = 1, },
                    { name = 'nvim_lua' },
                    { name = 'nvim_lsp_signature_help', max_item_count = 15 },
                    { name = 'luasnip' },
                    { name = 'nvim_lsp_document_symbol' },
                    { name = 'path',                    limit = 3,          max_item_count = 3 },
                    { name = 'rg',                      keyword_length = 2, max_item_count = 5 },
                }, {
                    { name = 'buffer', limit = 3, keyword_length = 3 },
                })
            })
        end
    },
    {
        'neovim/nvim-lspconfig',
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'j-hui/fidget.nvim',                tag = "legacy", opts = {} },
            'folke/neodev.nvim',
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'simrat39/rust-tools.nvim' },
        },
        config = function()
            -- vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
            local lsp = require('lsp-zero')
            lsp.extend_lspconfig()
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

            lsp.on_attach(function(client, bufnr)
                -- lsp.default_keymaps({ buffer = bufnr })
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
                vim.keymap.set('n', '<leader>ws',
                    function() require('telescope.builtin').lsp_dynamic_workspace_symbols() end,
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

            require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {
                    lsp.default_setup,
                    gopls = function()
                        require('lspconfig').gopls.setup({
                            -- gopls_cmd = { install_root_dir .. '/go/gopls' },
                            fillstruct = 'gopls',
                            dap_debug = true,
                            dap_debug_gui = true
                        })
                    end,
                    lua_ls = function()
                        require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
                    end,
                    rust_analyzer = function()
                        local rust_lsp = lsp.build_options('rust_analyzer', {
                            settings = {
                                ["rust-tools"] = {
                                    lens = { enable = true, },
                                    check = {}
                                }
                            }
                        })

                        require('rust-tools').setup({ server = rust_lsp })
                    end
                }
            })
            -- (Optional) Configure lua language server for neovim
            -- require('lspconfig').zls.setup({})
            -- require('lspconfig').tsserver.setup({})
            -- require('lspconfig').gopls.setup({})


            -- lsp.setup()
        end
    }
}
