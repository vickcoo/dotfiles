---@type vim.lsp.Config
return {
    cmd = { 'beancount-language-server', '--stdio' },
    filetypes = { 'beancount', 'bean' },
}
