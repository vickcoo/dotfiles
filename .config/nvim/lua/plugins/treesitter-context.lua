return {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        max_lines = 3,        -- 最多釘幾行 context，0 = 不限
        multiline_threshold = 1,
        trim_scope = "outer", -- 超過 max_lines 時，優先砍最外層
        mode = "cursor",      -- 依游標位置決定 context
    },
    keys = {
        -- 跳回目前 context 的開頭（例如 function 那一行）
        {
            "[c",
            function()
                require("treesitter-context").go_to_context(vim.v.count1)
            end,
            desc = "Jump to context",
        },
    },
}
