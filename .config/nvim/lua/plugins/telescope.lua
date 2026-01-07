return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader><leader>', builtin.keymaps, { desc = 'telescope: telescope lists all normal mode keymappings' })
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'telescope: telescope find files' })
            vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'telescope: telescope find git files' })
            vim.keymap.set('n', '<leader>fs', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") });
            end, { desc = "telescope: search text in global" })
        end,
    }
}
