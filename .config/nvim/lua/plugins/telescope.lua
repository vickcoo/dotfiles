return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "master",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader><leader>', builtin.keymaps, { desc = 'telescope: telescope lists all normal mode keymappings' })
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'telescope: telescope find files' })
            vim.keymap.set('n', '<leader>fg', builtin.git_status, { desc = 'telescope: list all changes file' })
            vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'telescope: telescope find git files' })
            vim.keymap.set('n', '<leader>fs', function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") });
            end, { desc = "telescope: search text in global" })
            vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'telescope: live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'telescope: list open buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'telescope: search help tags' })
        end,
    }
}
