-- Java LSP is driven by ftplugin/java.lua (jdtls.start_or_attach), so this spec
-- only needs to install the plugin and load it when a Java buffer opens.
return {
    "mfussenegger/nvim-jdtls",
    ft = "java",
}
