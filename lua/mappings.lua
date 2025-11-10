require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", "<leader>fr", "<cmd>Telescope neoclip<CR>", { desc = "telescope neoclip (registries)" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { desc = "telescope keymaps" })
map("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", { desc = "telescope LSP References" })
map("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>", { desc = "telescope LSP Implementations" })
map("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", { desc = "telescope LSP Definitions" })
map("n", "<leader>lt", "<cmd>Telescope lsp_type_Definitions<CR>", { desc = "telescope LSP Type Definitions" })
map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "telescope LSP Buffer Symbols" })
map("n", "<leader>li", "<cmd>Telescope lsp_incoming_calls<CR>", { desc = "telescope LSP Incoming Calls" })
map("n", "<leader>lo", "<cmd>Telescope lsp_outgoing_calls<CR>", { desc = "telescope LSP Outgoing Calls" })

map(
  "n",
  "<leader>ff",
  "<cmd>Telescope find_files find_command=rg,--files,--color,never,-g,!.git/* hidden=true<cr>",
  { desc = "telescope find files" }
)
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files find_command=rg,--files,--color,never,-g,!node_modules/* follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

-- Hop
-- https://github.com/smoka7/hop.nvim/wiki/Advanced-Hop

local hop = require "hop"
local directions = require("hop.hint").HintDirection
map("", "f", function()
  hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true }
end, { remap = true, desc = "Move to Next char" })
map("", "F", function()
  hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true }
end, { remap = true, desc = "Move to Previous char" })
map("", "t", function()
  hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }
end, { remap = true, desc = "Move before next char" })
map("", "T", function()
  hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }
end, { remap = true, desc = "Move before previous char" })

map("n", "<leader>mw", function()
  hop.hint_words { multi_windows = true }
end, { desc = "Move to Word in any window" })
