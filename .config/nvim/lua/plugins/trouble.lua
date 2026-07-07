return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "trouble: diagnostics (project)" },
        { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "trouble: diagnostics (buffer)" },
        { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "trouble: symbols" },
        { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "trouble: quickfix list" },
        { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "trouble: location list" },
    },
}
