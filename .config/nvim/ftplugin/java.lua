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

-- Debug + test support: hand jdtls the java-debug-adapter and vscode-java-test
-- bundles (installed via Mason) so it can drive nvim-dap.
local mason_pkg = vim.fn.stdpath("data") .. "/mason/packages/"
local bundles = vim.fn.glob(
    mason_pkg .. "java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true, true)
vim.list_extend(bundles, vim.fn.glob(mason_pkg .. "java-test/extension/server/*.jar", true, true))

-- LSP keymaps (gd, gr, K, <space>ca, <space>f, ...) come from the shared
-- LspAttach autocmd in lua/lsp.lua. Debug/test bindings below are buffer-local
-- to Java; generic session control (continue, step, ...) lives in nvim-dap.lua.
jdtls.start_or_attach({
    cmd = { "jdtls", "-data", workspace_dir },
    root_dir = root_dir,
    capabilities = capabilities,
    init_options = { bundles = bundles },
    on_attach = function(_, bufnr)
        require("jdtls").setup_dap({ hotcodereplace = "auto" })
        require("jdtls.dap").setup_dap_main_class_configs()

        local opts = { buffer = bufnr, silent = true }
        vim.keymap.set("n", "<leader>b", function() require("dap").toggle_breakpoint() end,
            vim.tbl_extend("force", opts, { desc = "java: toggle breakpoint" }))
        vim.keymap.set("n", "<leader>dt", function() require("jdtls").test_nearest_method() end,
            vim.tbl_extend("force", opts, { desc = "java: debug nearest test method" }))
        vim.keymap.set("n", "<leader>dT", function() require("jdtls").test_class() end,
            vim.tbl_extend("force", opts, { desc = "java: debug test class" }))
    end,
})
