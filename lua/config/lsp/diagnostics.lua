local M = {}

function M.setup(options)
    local signs = { Error = "✗ ", Warn = "▲ ", Hint = "! ", Info = "▶ " }

    for severity, icon in pairs(signs) do
        local highlight = "DiagnosticSign" .. severity
        vim.fn.sign_define(highlight, { text = icon, texthl = highlight, numhl = highlight })
    end

    vim.diagnostic.config(vim.deepcopy(options))
end

return M
