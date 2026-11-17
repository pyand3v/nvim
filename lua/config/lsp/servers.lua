local M = {}

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
