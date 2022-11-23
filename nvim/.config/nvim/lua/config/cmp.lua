local M = {}

local has_words_before = function()
  ---@diagnostic disable-next-line: deprecated
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

function M.setup()
  -- nvim-cmp setup
  local cmp = require "cmp"
  local compare = require "cmp.config.compare"

  local luasnip = require "luasnip"
  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      documentation = cmp.config.window.bordered(),
      completion = {
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
        col_offset = -3,
        side_padding = 0,
      },
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, item)
        local kind = require("lspkind").cmp_format {
          mode = "symbol_text",
          maxwidth = 50,
        }(entry, item)
        local strings = vim.split(kind.kind, "%s", {
          trimempty = true,
        })
        kind.kind = " " .. strings[1] .. " "
        kind.menu = "    (" .. strings[2] .. ")"
        return kind
      end,
    },
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },
    sorting = {
      priority_weight = 2,
      comparators = {
        require "cmp_fuzzy_buffer.compare",
        compare.kind,
        compare.recently_used,
        compare.score,
        compare.offset,
        compare.exact,
        compare.sort_text,
        compare.length,
        compare.order,
      },
    },
    sources = {
      { name = "nvim_lsp_signature_help" },
      { name = "nvim_lsp", keyworld_length = 2 },
      { name = "luasnip", keyword_length = 2, priority = 50 },
      { name = "buffer", keyword_length = 3 },
      { name = "fuzzy_buffer", keyword_length = 3 },
      { name = "rg", keyword_length = 3 },
    },
  }

  cmp.setup.cmdline("/", {
    sources = {
      { name = "buffer" },
      { name = "rg", keyword_length = 3 },
      { name = "path" },
    },
  })
end

return M
