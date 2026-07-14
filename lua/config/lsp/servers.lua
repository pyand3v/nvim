local M = {}

M.ensure_installed = {
    "lua_ls",
    "ts_ls",
    "html",
    "cssls",
    "clangd",
    "tailwindcss",
    "emmet_ls",
    "rust_analyzer",
    "zls",
    "gopls",
}

function M.setup()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
            },
        },
    })

    vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        filetypes = { "javascript", "typescript" },
    })

    vim.lsp.config("emmet_ls", {
        capabilities = capabilities,
        filetypes = {
            "html",
            "typescriptreact",
            "javascriptreact",
            "css",
            "sass",
            "scss",
            "less",
            "svelte",
        },
    })

    vim.lsp.config("gopls", {
        capabilities = capabilities,
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
    })
end

return M
