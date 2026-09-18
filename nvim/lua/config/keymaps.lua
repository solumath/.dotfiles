-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Map Ctrl + / to toggle comments in Normal and Visual mode
vim.keymap.set("n", "<C-/>", "gcc", { remap = true, desc = "Toggle Comment" })
vim.keymap.set("n", "<C-_>", "gcc", { remap = true, desc = "Toggle Comment" }) -- backward compat alias
vim.keymap.set("n", "<C-S-/>", "gcc", { remap = true, desc = "Toggle Comment" })
vim.keymap.set("n", "<C-S-{>", "gcc", { remap = true, desc = "Toggle Comment" })
vim.keymap.set("v", "<C-/>", "gc", { remap = true, desc = "Toggle Comment" })
vim.keymap.set("v", "<C-_>", "gc", { remap = true, desc = "Toggle Comment" }) -- backward compat alias
vim.keymap.set("v", "<C-S-/>", "gc", { remap = true, desc = "Toggle Comment" })
vim.keymap.set("v", "<C-S-{>", "gc", { remap = true, desc = "Toggle Comment" })

-- Delete word backward/forward in Insert Mode
vim.keymap.set("i", "<C-Delete>", "<C-o>de", { noremap = true, silent = true })
vim.keymap.set("i", "<C-BS>", "<C-w>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-H>", "<C-w>", { noremap = true, silent = true })

-- Jump words forward/backward in Insert Mode
vim.keymap.set("i", "<C-Left>", "<C-o>b", { noremap = true })
vim.keymap.set("i", "<C-Right>", "<C-o>w", { noremap = true })

-- Also useful for Normal Mode if you prefer the arrows
vim.keymap.set("n", "<C-Left>", "b", { noremap = true })
vim.keymap.set("n", "<C-Right>", "w", { noremap = true })

-- Fallback: raw escape sequences sent by some terminals (e.g. Debian 13 / xterm)
vim.keymap.set("i", "<Esc>OD", "<C-o>b", { noremap = true, silent = true })
vim.keymap.set("i", "<Esc>OC", "<C-o>w", { noremap = true, silent = true })
vim.keymap.set("n", "<Esc>OD", "b", { noremap = true, silent = true })
vim.keymap.set("n", "<Esc>OC", "w", { noremap = true, silent = true })

-- VSCode-style rename
vim.keymap.set({ "n", "i" }, "<F2>", vim.lsp.buf.rename, { desc = "Rename" })

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, desc = "Select All" })
