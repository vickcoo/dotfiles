return {
    {
        "scottmckendry/cyberdream.nvim",
        config = function()
            require("cyberdream").setup({
                transparent = true,
            })
            vim.cmd("colorscheme cyberdream")
        end,
    }
}
