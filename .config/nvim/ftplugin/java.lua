-- Runs on every Java buffer. jdtls.start_or_attach reuses a running server when
-- the project root matches, so opening more files in the same project is cheap.
local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
    return
end

-- Detect the project root: Maven first, then Gradle, then plain git.
local root_dir = vim.fs.root(0, { "pom.xml", "mvnw", "settings.gradle", "build.gradle", ".git" })
if not root_dir then
    return
end

-- Give each project its own jdtls workspace under the cache dir.
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. project_name

-- Advertise nvim-cmp capabilities, matching the other LSP servers.
local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = cmp_ok and cmp_nvim_lsp.default_capabilities() or nil

-- LSP keymaps (gd, gr, K, <space>ca, <space>f, ...) come from the shared
-- LspAttach autocmd in lua/lsp.lua, so nothing extra is needed here.
jdtls.start_or_attach({
    cmd = { "jdtls", "-data", workspace_dir },
    root_dir = root_dir,
    capabilities = capabilities,
})
