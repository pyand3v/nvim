return {
    "neovim/nvim-lspconfig",
    name = "LspConfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "hrsh7th/cmp-nvim-lsp",
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

        require("mason-lspconfig").setup({
            ensure_installed = require("config.lsp.servers").ensure_installed,
            automatic_enable = {
                -- luau-lsp.nvim starts and configures its own Luau client.
                exclude = {
                    "luau_lsp",
                    -- rustaceanvim owns the Rust LSP client lifecycle.
                    "rust_analyzer",
                },
            },
        })

        require("mason-tool-installer").setup({
            ensure_installed = {
                "stylua",
                "selene",
                "prettier",
                "clang-format",
                "delve",
                "gofumpt",
                "goimports",
                "shfmt",
                -- luau-lsp.nvim manages this server after Mason installs it.
                "luau-lsp",
            },
            run_on_start = true,
        })
    end,
}
