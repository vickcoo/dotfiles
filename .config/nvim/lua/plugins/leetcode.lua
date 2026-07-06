return {
    {
        "kawre/leetcode.nvim",
        -- html parser 由 treesitter.lua 的 install 清單負責，這裡不需要 build 步驟
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-telescope/telescope.nvim",
        },
        opts = {
            lang = "python3",
            picker = { provider = "telescope" },
        },
    }
}
