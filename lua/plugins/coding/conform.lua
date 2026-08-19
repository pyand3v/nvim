return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({
                    async = true,
                    lsp_format = "fallback",
                })
            end,
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            javascript = { "prettier" },
            javascriptreact = { "prettier" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
            json = { "prettier" },
            jsonc = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
            markdown = { "prettier" },
            yaml = { "prettier" },
        },
        format_on_save = {
            timeout_ms = 500,
            lsp_format = "fallback",
        },
    },
}
