return {
    {
        "ThePrimeagen/vim-be-good",
        config = function()
            vim.keymap.set("n", "<leader><leader>game", vim.cmd.VimBeGood, { desc = "VimBeGood: start game" })
        end,
    }
}
