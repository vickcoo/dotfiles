return {
    "f-person/auto-dark-mode.nvim",
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        set_dark_mode = function()
            vim.api.nvim_set_option_value("background", "dark", {})
            vim.cmd("colorscheme cyberdream")
        end,
        set_light_mode = function()
            vim.api.nvim_set_option_value("background", "light", {})
            vim.cmd("colorscheme github_light")
        end,
        fallback = "dark",
    }
}
