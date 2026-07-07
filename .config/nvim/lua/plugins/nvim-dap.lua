-- Generic DAP core. The keymaps here are language-agnostic: require('dap')
-- dispatches to whichever adapter is registered for the current buffer's
-- filetype. Language-specific launch/test actions live with each language
-- (Swift: plugins/xcodebuild-nvim.lua, Java: ftplugin/java.lua).
return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")

    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "dap: continue / start" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "dap: step into" })
    vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "dap: step over" })
    vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "dap: step out" })
    vim.keymap.set("n", "<leader>de", function() dap.repl.toggle() end, { desc = "dap: toggle repl" })
  end,
}
