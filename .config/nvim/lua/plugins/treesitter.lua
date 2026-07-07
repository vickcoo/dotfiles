return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            require("nvim-treesitter.configs").setup({
                -- 要安裝的 parser
                ensure_installed = {
                    "c", "lua", "vim", "vimdoc", "query",
                    "markdown", "markdown_inline",
                    "javascript", "typescript", "tsx", "swift", "solidity",
                    "html", "java",
                },
                auto_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    }
}
