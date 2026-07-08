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

-- Lombok javaagent: jdtls does NOT run Lombok's annotation processor by default,
-- so @Data / @Getter generated methods (getAccount(), setSubject(), ...) show up
-- as "method is undefined" errors. Attaching lombok.jar as a javaagent fixes it
-- (this is what IntelliJ's Lombok plugin does internally).
--
-- Resolve lombok.jar without hardcoding a version/machine: pick the newest jar
-- Maven has already downloaded under ~/.m2 (sources jars excluded). Any recent
-- lombok works as the agent -- it need not match the project's exact version.
local lombok_jar
do
    -- Expand only ~ here; leave the * wildcards for glob(). Passing the whole
    -- pattern through expand() would itself expand the wildcards into a newline-
    -- joined string, which glob() then can't match (candidates comes back empty).
    local pattern = vim.fn.expand("~") .. "/.m2/repository/org/projectlombok/lombok/*/lombok-*.jar"
    local candidates = vim.fn.glob(pattern, true, true)
    candidates = vim.tbl_filter(function(p) return not p:match("%-sources%.jar$") end, candidates)
    table.sort(candidates) -- lexical sort is good enough to prefer a higher version last
    lombok_jar = candidates[#candidates]
    if not lombok_jar then
        vim.notify("jdtls: lombok.jar not found under ~/.m2 -- run a Maven build first, "
            .. "else Lombok getters/setters will show as undefined", vim.log.levels.WARN)
    end
end

-- Base launch command; splice in the Lombok javaagent only when we found a jar.
local cmd = { "jdtls", "-data", workspace_dir }
if lombok_jar then
    table.insert(cmd, 2, "--jvm-arg=-javaagent:" .. lombok_jar)
end

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
    cmd = cmd,
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
