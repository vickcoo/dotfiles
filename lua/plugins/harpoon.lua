return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup()
            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "harpoon: add current file to harpoon" })
            vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "harpoon: toggle harpoon menu" })

            vim.keymap.set("n", "<leader>h", function() harpoon:list():select(1) end, { desc = "harpoon: quick jump to harpoon 1 item" })
            vim.keymap.set("n", "<leader>j", function() harpoon:list():select(2) end, { desc = "harpoon: quick jump to harpoon 2 item" })
            vim.keymap.set("n", "<leader>k", function() harpoon:list():select(3) end, { desc = "harpoon: quick jump to harpoon 3 item" })
            vim.keymap.set("n", "<leader>l", function() harpoon:list():select(4) end, { desc = "harpoon: quick jump to harpoon 4 item" })
        end,
    }
}
