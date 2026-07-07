vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true, desc = "vickcoo: exit insert mode" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "vickcoo: scroll down half page and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "vickcoo: scroll up half page and center" })

vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "vickcoo: paste without yanking" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "vickcoo: yank to system clipboard" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "vickcoo: move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "vickcoo: move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "vickcoo: move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "vickcoo: move to right window" })
