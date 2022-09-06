local M = {}

function M.setup()
  local tele = require "telescope"
  local action_layout = require "telescope.actions.layout"
  tele.load_extension "fzf"
  tele.load_extension "harpoon"
  -- tele.load_extension "project"

  -- local actions = require "telescope.actions"

  tele.setup {
    find_command = {
      "rg",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!.git",
    },
    use_less = true,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    extensions = {
      fzf = {
        override_generic_sorter = false,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
    defaults = {
      file_ignore_patterns = {
        "node_modules",
        ".git/",
      },
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<C-u>"] = false,
          ["<C-d>"] = false,
          ["?"] = action_layout.toggle_preview,
        },
      },
    },
  }

  tele.load_extension "dap"

  vim.api.nvim_set_keymap(
    "n",
    "<leader>B",
    [[<cmd>lua require('telescope.builtin').buffers()<CR>]],
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>sf",
    [[<cmd>lua require('telescope.builtin').find_files({hidden = true})<CR>]],
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>sh",
    [[<cmd>lua require('telescope.builtin').help_tags()<CR>]],
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>qf",
    [[<cmd>lua require('telescope.builtin').quickfix()<CR>]],
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>sd",
    [[<cmd>lua require('telescope.builtin').grep_string({hidden = true})<CR>]],
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>sp",
    [[<cmd>lua require('telescope.builtin').live_grep({hidden = true})<CR>]],
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>col",
    [[<cmd>lua require('telescope.builtin').colorscheme()<CR>]],
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>?",
    [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]],
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap("n", "<C-p>", [[:Telescope<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<leader>fr", [[:Telescope resume<CR>]], { noremap = true, silent = true })
  vim.api.nvim_set_keymap(
    "n",
    "<leader>/",
    [[:Telescope current_buffer_fuzzy_find<CR>]],
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>ps",
    [[<cmd>lua require('telescope.builtin').grep_string({ hidden = true, search = vim.fn.input("Grep For > ")})<CR>]],
    { noremap = true, silent = true }
  )
end

return M
