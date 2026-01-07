-- Custom Command
vim.api.nvim_create_user_command("HoverRaw", function()
    local params = vim.lsp.util.make_position_params()
    vim.lsp.buf_request(0, "textDocument/hover", params, function(err, result, ctx, _)
        if err then
            print("LSP Error:", err)
            return
        end
        print(vim.inspect(result))
    end)
end, {})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local help_name = vim.api.nvim_buf_get_name(buf)    -- 取得完整路徑
        local title = vim.fn.fnamemodify(help_name, ":t:r") -- 只取檔名
        -- close origin window
        vim.cmd("close")

        -- create new floating window
        local width = math.floor(vim.o.columns * 0.5)
        local height = math.floor(vim.o.lines * 0.9)
        local row = 1
        local col = vim.o.columns - width
        local win = vim.api.nvim_open_win(buf, true, {
            relative = "editor",
            width = width,
            height = height,
            row = row,
            col = col,
            style = "minimal",
            border = "rounded",
            title = " HELP:" .. title,
            title_pos = "center",
        })

        -- vim.bo.bufhidden = 'wipe'
        vim.bo[buf].bufhidden = 'wipe'
        -- vim.cmd("wincmd L")
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, silent = true })
    end,
})
