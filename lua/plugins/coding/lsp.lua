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
            -- Tool versions and installation belong to config.tools.
            ensure_installed = {},
            automatic_enable = {
                -- luau-lsp.nvim starts and configures its own Luau client.
                exclude = {
                    "luau_lsp",
                    -- rustaceanvim owns the Rust LSP client lifecycle.
                    "rust_analyzer",
                },
            },
        })

        local tools = vim.tbl_map(function(tool)
            return { tool.name, version = tool.version }
        end, require("config.tools"))
        require("mason-tool-installer").setup({
            ensure_installed = tools,
            run_on_start = false,
            auto_update = false,
            integrations = {
                ["mason-lspconfig"] = false,
                ["mason-null-ls"] = false,
                ["mason-nvim-dap"] = false,
            },
        })
    end,
}
