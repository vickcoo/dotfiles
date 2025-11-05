vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.updatetime = 100

-- Diagnostic signs
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
            [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
            [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
        },
    }
})

-- Color
vim.api.nvim_set_hl(0, "NvimTreeGitDirty", { fg = "#e0af68" })
vim.api.nvim_set_hl(0, "NvimTreeGitStaged", { fg = "#2ccc4a" })
vim.api.nvim_set_hl(0, "NvimTreeGitMerge", { fg = "#d3869b" })
vim.api.nvim_set_hl(0, "NvimTreeGitRenamed", { fg = "#7aa2f7" })
vim.api.nvim_set_hl(0, "NvimTreeGitNew", { fg = "#a9b1d6" })
vim.api.nvim_set_hl(0, "NvimTreeGitDeleted", { fg = "#f7768e" })
vim.api.nvim_set_hl(0, "NvimTreeGitIgnored", { fg = "#565f89" })
