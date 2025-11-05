---@brief
--- Lua Language Server (lua_ls) configuration
--- Based on recommended settings; adapts to Neovim runtime and user config.

local util = require 'lspconfig.util'
local cmp_caps_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
local cmp_caps = cmp_caps_ok and cmp_nvim_lsp.default_capabilities() or nil

---@type vim.lsp.Config
return {
  cmd = { 'lua-language-server' },

  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath('config')
        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    })
  end,

  settings = {
    Lua = {},
  },

  root_dir = function(bufnr, on_dir)
    local filename = vim.api.nvim_buf_get_name(bufnr)
    on_dir(
      util.root_pattern('.luarc.json', '.luarc.jsonc')(filename)
      or util.root_pattern('.git')(filename)
      or vim.fs.dirname(vim.fs.find('.git', { path = filename, upward = true })[1])
      or util.path.dirname(filename)
    )
  end,

  capabilities = (function()
    local base = {}
    if cmp_caps then
      return vim.tbl_deep_extend('force', cmp_caps, base)
    end
    return base
  end)(),
}


