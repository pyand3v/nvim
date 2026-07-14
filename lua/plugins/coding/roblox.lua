return {
    {
        "lopi-py/luau-lsp.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            -- luau-lsp.nvim owns the LSP client and server lifecycle.
            platform = {
                type = "roblox",
            },
            -- Connect to the Luau Language Server Companion in Roblox Studio.
            -- Install and enable the Studio plugin separately; it listens locally.
            plugin = {
                enabled = true,
                port = 3667,
            },
            sourcemap = {
                enabled = true,
                autogenerate = true,
                rojo_project_file = "default.project.json",
                sourcemap_file = "sourcemap.json",
            },
        },
    },
}
