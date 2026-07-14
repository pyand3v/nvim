return {
    "neovim/nvim-lspconfig",
    name = "LspConfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        { "folke/lazydev.nvim", ft = "lua", opts = {} },
    },
    opts = {
        diagnostics = {
            underline = true,
            severity_sort = true,
            virtual_text = {
                source = "if_many",
                prefix = "● ",
            },
        },
    },
    config = function(_, options)
        require("config.lsp.diagnostics").setup(options.diagnostics)
        require("config.lsp.keymaps")
        require("config.lsp.servers").setup()

        require("mason").setup({
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➞",
                    package_uninstalled = "✗",
                },
            },
        })

        require("mason-lspconfig").setup({
            ensure_installed = require("config.lsp.servers").ensure_installed,
            automatic_enable = {
                -- luau-lsp.nvim starts and configures its own Luau client.
                exclude = { "luau_lsp" },
            },
        })

        require("mason-tool-installer").setup({
            ensure_installed = {
                "stylua",
                "selene",
                "prettier",
                "delve",
                -- luau-lsp.nvim manages this server after Mason installs it.
                "luau-lsp",
            },
            run_on_start = true,
        })
    end,
}
