local group = vim.api.nvim_create_augroup("ConfigLspKeymaps", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(event)
        local options = { buffer = event.buf }

        options.desc = "Go to definition"
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, options)

        options.desc = "Hover documentation"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, options)

        options.desc = "Workspace symbol search"
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, options)

        options.desc = "Open diagnostic float"
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, options)

        options.desc = "Code action"
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, options)

        options.desc = "References"
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, options)

        options.desc = "Rename symbol"
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, options)

        options.desc = "Signature help"
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, options)
    end,
})
