vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true, desc = "vickcoo: exit insert mode" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "vickcoo: scroll down half page and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "vickcoo: scroll up half page and center" })
vim.keymap.set("n", "J", "5j", { desc = "vickcoo: scroll down by 5 lines rapidly" })
vim.keymap.set("n", "K", "5k", { desc = "vickcoo: scroll up by 5 lines rapidly" })

vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "vickcoo: paste without yanking" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "vickcoo: yank to system clipboard" })
