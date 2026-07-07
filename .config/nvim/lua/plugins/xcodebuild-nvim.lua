return {
  "wojciech-kulik/xcodebuild.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
    "mfussenegger/nvim-dap",
  },
  config = function()
    require("xcodebuild").setup({ 
       logs = {
        logs_formatter = nil,
      },
      code_coverage = {
        enabled = true,
      },
    })
 
    vim.keymap.set("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", { desc = "xcodebuild.nvim: toggle Xcodebuild Logs" })
    vim.keymap.set("n", "<leader>xb", "<cmd>XcodebuildBuild<cr>", { desc = "xcodebuild.nvim: build Project" })
    vim.keymap.set("n", "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", { desc = "xcodebuild.nvim: build & Run Project" })
    vim.keymap.set("n", "<leader>xt", "<cmd>XcodebuildTest<cr>", { desc = "xcodebuild.nvim: run Tests" })
    vim.keymap.set("n", "<leader>xT", "<cmd>XcodebuildTestClass<cr>", { desc = "xcodebuild.nvim: run This Test Class" })
    vim.keymap.set("n", "<leader>X", "<cmd>XcodebuildPicker<cr>", { desc = "xcodebuild.nvim: show All Xcodebuild Actions" })
    vim.keymap.set("n", "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "xcodebuild.nvim: select Device" })
    vim.keymap.set("n", "<leader>xp", "<cmd>XcodebuildSelectTestPlan<cr>", { desc = "xcodebuild.nvim: select Test Plan" })
    vim.keymap.set("n", "<leader>xc", "<cmd>XcodebuildToggleCodeCoverage<cr>", { desc = "xcodebuild.nvim: toggle Code Coverage" })
    vim.keymap.set("n", "<leader>xC", "<cmd>XcodebuildShowCodeCoverageReport<cr>", { desc = "xcodebuild.nvim: show Code Coverage Report" })
    vim.keymap.set("n", "<leader>xq", "<cmd>Telescope quickfix<cr>", { desc = "xcodebuild.nvim: show QuickFix List" })

    -- Swift/Xcode DAP integration. Generic session control (continue, step, ...)
    -- lives in plugins/nvim-dap.lua; these keys are the Xcode-specific launch,
    -- test, and breakpoint actions (the breakpoint/terminate wrappers also
    -- persist breakpoints to disk and cancel the running build).
    local xcodebuild_dap = require("xcodebuild.integrations.dap")
    xcodebuild_dap.setup()

    vim.keymap.set("n", "<leader>dd", xcodebuild_dap.build_and_debug, { desc = "swift: build & debug" })
    vim.keymap.set("n", "<leader>dr", xcodebuild_dap.debug_without_build, { desc = "swift: debug without building" })
    vim.keymap.set("n", "<leader>dt", xcodebuild_dap.debug_tests, { desc = "swift: debug tests" })
    vim.keymap.set("n", "<leader>dT", xcodebuild_dap.debug_class_tests, { desc = "swift: debug class tests" })
    vim.keymap.set("n", "<leader>b", xcodebuild_dap.toggle_breakpoint, { desc = "swift: toggle breakpoint" })
    vim.keymap.set("n", "<leader>B", xcodebuild_dap.toggle_message_breakpoint, { desc = "swift: toggle message breakpoint" })
    vim.keymap.set("n", "<leader>dx", xcodebuild_dap.terminate_session, { desc = "swift: terminate debugger" })
  end,
}

