return {
    "mason-org/mason.nvim",
    lazy = false,
    opts = {
        -- Freeze installation recipes as well as package versions in config.tools.
        registries = { "github:mason-org/mason-registry@2026-11-17-aching-puffin" },
        ui = {
            border = "rounded",
            icons = {
                package_installed = "✓",
                package_pending = "➞",
                package_uninstalled = "✗",
            },
        },
    },
}
