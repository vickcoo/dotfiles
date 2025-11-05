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