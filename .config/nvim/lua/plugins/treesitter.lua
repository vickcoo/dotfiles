return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        lazy = false,
        config = function()
            -- 要安裝的 parser
            require("nvim-treesitter").install({
                "c", "lua", "vim", "vimdoc", "query",
                "markdown", "markdown_inline",
                "javascript", "typescript", "swift", "solidity",
            })

            -- 開檔時依 filetype 啟用 treesitter 上色
            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
                    if lang and pcall(vim.treesitter.language.inspect, lang) then
                        pcall(vim.treesitter.start)
                    end
                end,
            })
        end,
    }
}
