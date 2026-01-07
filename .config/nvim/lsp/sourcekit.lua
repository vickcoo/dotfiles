---@brief
---
--- https://github.com/swiftlang/sourcekit-lsp
---
--- Language server for Swift and C/C++/Objective-C.

local util = require 'lspconfig.util'
local cmp_caps_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
local cmp_caps = cmp_caps_ok and cmp_nvim_lsp.default_capabilities() or nil

---@type vim.lsp.Config
return {
  cmd = { 'sourcekit-lsp' },
  filetypes = { 'swift', 'objc', 'objcpp', 'c', 'cpp' },
  root_dir = function(bufnr, on_dir)
    local filename = vim.api.nvim_buf_get_name(bufnr)
    on_dir(
      util.root_pattern 'buildServer.json'(filename)
        or util.root_pattern('*.xcodeproj', '*.xcworkspace')(filename)
        -- better to keep it at the end, because some modularized apps contain multiple Package.swift files
        or util.root_pattern('compile_commands.json', 'Package.swift')(filename)
        or vim.fs.dirname(vim.fs.find('.git', { path = filename, upward = true })[1])
    )
  end,
  get_language_id = function(_, ftype)
    local t = { objc = 'objective-c', objcpp = 'objective-cpp' }
    return t[ftype] or ftype
  end,
  capabilities = (function()
    local base = {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
      textDocument = {
        diagnostic = {
          dynamicRegistration = true,
          relatedDocumentSupport = true,
        },
      },
    }
    if cmp_caps then
      return vim.tbl_deep_extend('force', cmp_caps, base)
    end
    return base
  end)(),
}
