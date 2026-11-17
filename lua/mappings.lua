require "nvchad.mappings"
--disable some keymaps that i want to override or nuke
local nomap = vim.keymap.del
nomap("n", "<C-n>")
nomap("n", "<leader>e")

nomap("n", "<leader>h")
nomap("n", "<leader>v")
-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<C-Q>", "<Cmd>q!<CR>", { desc = "Force quit" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("t", "<C-d>", "<C-\\><C-n>:bd!<CR>", { desc = "force terminal close " })
--mouse menus
-- Keyboard users
vim.keymap.set("n", "<C-t>", function()
  require("menu").open "default"
end, {})

-- mouse users + nvimtree users!
vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
  require("menu.utils").delete_old_menus()

  vim.cmd.exec '"normal! \\<RightMouse>"'

  -- clicked buf
  local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
  local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

  require("menu").open(options, { mouse = true })
end, {})
-- yazi

map("n", "<leader>e", "<cmd>Yazi<CR>", { desc = "Open yazi at the current file" })
-- LSP Code mappings (agregar al final de tu mappings.lua)
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions & fixes" })
map("n", "<leader>cR", vim.lsp.buf.rename, { desc = "Code rename symbol" })

-- Telescope LSP and other things
map("n", "<leader>cs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Code symbols (document)" })
map("n", "<leader>cS", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "Code symbols (workspace)" })
map("n", "<leader>cr", "<cmd>Telescope lsp_references<CR>", { desc = "Code references" })
map("n", "<leader>cd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Code definitions" })
-- snippets
map("n", "<leader>fs", "<cmd>Telescope luasnip<cr>", { desc = "Snippets available" })
-- Diagnostics
map("n", "<leader>ce", vim.diagnostic.open_float, { desc = "Code error details" })
map("n", "<leader>cl", "<cmd>Telescope diagnostics<CR>", { desc = "Code list diagnostics" })

-- neotree
-- local opts = { noremap = true, silent = true, desc = "" }
--
-- -- <leader>e para abrir/cerrar NeoTree
-- map("n", "<leader>e", "<cmd>Neotree toggle<CR>", vim.tbl_extend("force", opts, {
--   desc = "Toggle Explorer",
-- }))
--
-- -- <leader>o para alternar foco entre NeoTree y archivo actual
-- map("n", "<leader>o", function()
--   if vim.bo.filetype == "neo-tree" then
--     vim.cmd.wincmd("p")
--   else
--     vim.cmd("Neotree focus")
--   end
-- end, vim.tbl_extend("force", opts, {
--   desc = "Toggle Explorer Focus",
-- }))
