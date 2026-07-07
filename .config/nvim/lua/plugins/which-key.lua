return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        -- 按下 leader 後多久跳出提示面板(毫秒)
        delay = 300,
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "which-key: show buffer-local keymaps",
        },
    },
}
