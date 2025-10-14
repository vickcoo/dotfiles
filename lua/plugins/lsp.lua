-- lua/plugins/lsp_and_completion.lua
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      -- ========= LSP =========
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      -- Swift LSP
      lspconfig.sourcekit.setup {
        default_config = {
          --cmd = { "xcrun", "sourcekit-lsp" },
          cmd = { "sourcekit-lsp" },
          filetypes = { "swift" },
          root_dir = lspconfig.util.root_pattern("Package.swift", ".git"),
          capabilities = capabilities,
        }
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "swift",
        callback = function()
          vim.lsp.start({ name = "sourcekit" })
        end,
      })

      -- LSP 快捷鍵
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP Actions",
        callback = function(args)
          local buf = args.buf
          local opts = { noremap = true, silent = true, buffer = buf }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        end,
      })

      -- ========= nvim-cmp =========
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "buffer" },
        }),
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
      })
    end,
  },
}

