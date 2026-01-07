return {
    {
        "scottmckendry/cyberdream.nvim",
        enabled = true,
        config = function()
            require("cyberdream").setup({
                transparent = true,
            })
            vim.cmd("colorscheme cyberdream")
        end,
    }
}
