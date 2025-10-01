-- Basic Settings
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.g.mapleader = " "

-- Better indentation keymaps
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

-- Better redo
vim.keymap.set('n', 'U', '<C-r>', { desc = 'Redo' })

-- Highlight text on yank
local augroup = vim.api.nvim_create_augroup("UserConfig", {})
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.opt.clipboard = "unnamedplus"

-- Include subdirectories in search
vim.opt.path:append("**")

-- Delete without yanking
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- Remove purple highlighting from if/else/while keywords
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "Conditional", { link = "Keyword" })
  end,
})

-- Also set it immediately
vim.api.nvim_set_hl(0, "Conditional", { link = "Keyword" })

-- LazyDocker bindings
vim.keymap.set("n", "<leader>ld", function()
  require("lazydocker").toggle()
end, { desc = "LazyDocker" })

-- -- File Explorer
-- vim.keymap.set('n', '<leader>e', function()
--     -- Check if current buffer is netrw
--     if vim.bo.filetype == 'netrw' then
--         vim.cmd('bd')      -- Close netrw buffer
--     else
--         vim.cmd('Explore') -- Open explorer
--     end
-- end, { desc = 'Toggle file explorer' })
vim.keymap.set("n", "<leader>e", "<CMD>Oil --float<CR>", { desc = "Open oil" })

-- Auto-reload files changed outside of Neovim
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  command = "checktime",
})
