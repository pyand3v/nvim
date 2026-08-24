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
    "pyright",
    "ruff",
    "bashls",
    "jsonls",
    "yamlls",
    "docker_language_server",
    "taplo",
    "marksman",
    "solidity_ls_nomicfoundation",
}

function M.setup()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.lsp.config("*", {
        capabilities = capabilities,
    })

    vim.lsp.config("lua_ls", {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
            },
        },
    })

    vim.lsp.config("emmet_ls", {
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
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
    })
end

return M
