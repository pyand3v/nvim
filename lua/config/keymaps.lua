vim.g.mapleader = " "

-- Editing ergonomics.
vim.keymap.set("n", "o", "o<Esc>0", { desc = "Insert line below and stay in normal mode" })
vim.keymap.set("n", "U", ":redo<CR>", { desc = "Redo change" })

-- Move selected lines and keep the selection active.
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

-- Keep context visible while navigating.
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and preserve cursor" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center cursor" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center cursor" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center cursor" })

vim.keymap.set("v", "d", '"+d', { desc = "Delete to system clipboard" })
vim.keymap.set("v", "y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "v", "n" }, "p", '"+p', { desc = "Paste from system clipboard" })

-- Navigate split windows with Alt+h/j/k/l.
vim.keymap.set("n", "<A-h>", "<C-w>h", { desc = "Focus left split" })
vim.keymap.set("n", "<A-j>", "<C-w>j", { desc = "Focus lower split" })
vim.keymap.set("n", "<A-k>", "<C-w>k", { desc = "Focus upper split" })
vim.keymap.set("n", "<A-l>", "<C-w>l", { desc = "Focus right split" })
