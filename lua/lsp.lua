local orig = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  opts.max_width = opts.max_width or 80
  opts.max_height = opts.max_height or 20
  --   opts.title = opts.title or " LSP Info"  -- 可改 icon
  return orig(contents, syntax, opts, ...)
end

-- Create new keymapping for lsps
-- LspAttach: After an LSP Client performs "initialize" and attaches to a buffer.
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local keymap = vim.keymap
		local lsp = vim.lsp
		local bufopts = { noremap = true, silent = true }

		keymap.set("n", "gr", lsp.buf.references, { desc = "lsp: show references", noremap = true, silent = true })
		keymap.set("n", "gd", lsp.buf.definition, { desc = "lsp: show definition", noremap = true, silent = true })
		keymap.set("n", "<space>rn", lsp.buf.rename, { desc = "lsp: rename symbol", noremap = true, silent = true })
		keymap.set("n", "K", lsp.buf.hover, { desc = "lsp: show hover information", noremap = true, silent = true })
		keymap.set("n", "<space>f", function()
			require("conform").format({ async = true, lsp_fallback = true })
		end, bufopts)
	end,
})

-- CursorHold: When the user doesn't press a key for the time specified with 'updatetime'
--             By default, `updatetime` is equal to 4000 ms
--
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focusable = false, source = "if_many" })
        vim.diagnostic.config {
            virtual_text = false,
            float = {
                header = false,
                border = 'rounded',
                focusable = true,
            },
        }
	end,
})

vim.lsp.enable({ "sourcekit", "lua_ls", "vimls" })
