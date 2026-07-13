return {
    "neovim/nvim-lspconfig",
    name = "LspConfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "WhoIsSethDaniel/mason-tool-installer.nvim" },
        { "folke/neodev.nvim", opt = {} },
    },
    opts = function()
        return {
            diagnostics = {
                underline = true,
                severity_sort = true,
                virtual_text = {
                    source = "if_many",
                    prefix = "● ",
                },
            },
        }
    end,
    config = function(_, opts)
        require("neodev").setup {}
        local border = {
            { "╭", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╮", "FloatBorder" },
            { "│", "FloatBorder" },
            { "╯", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╰", "FloatBorder" },
            { "│", "FloatBorder" },
        }

        local handler = {
            ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
            ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
        }

        -- TODO: floating window above the cursor
        -- vim.lsp.util.make_floating_popup_options(relative="cursor")

        local signs = { Error = "✗ ", Warn = "▲ ", Hint = "! ", Info = "▶ " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
        vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

        -- Here we configure Mason
        require("mason").setup {
            ui = {
                border = "rounded",
                icons = {
                    package_installed = "✓",
                    package_pending = "➞",
                    package_uninstalled = "✗",
                },
            },
        }
        local lspconfig = vim.lsp.config
        local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

        lspconfig("lua_ls", {
            -- capabilities = lsp_capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })

        lspconfig("ts_ls", {
            capabilities = lsp_capabilities,
            filetypes = {
                "javascript",
                "typescript",
            },
        })

        lspconfig("emmet_ls", {
            -- capabilities = capabilities,
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

        lspconfig("gopls", {
            filetypes = {
                "go",
                "gomod",
                "gowork",
                "gotmpl",
            }
        })

        -- servers we always want installed
        local ensure_installed = {
            "lua_ls",
            "ts_ls",
            "html",
            "cssls",
            "clangd",
            "tailwindcss",
            "emmet_ls",
            "rust_analyzer",
            -- "csharp_ls",
            "zls",
            "gopls",
        }

        -- Here is where we manage the installation of language servers
        require("mason-lspconfig").setup {
            ensure_installed = ensure_installed,
            automatic_enable = {
                -- luau-lsp.nvim starts and configures its own Luau client.
                exclude = { "luau_lsp" },
            },
            -- handlers = handlers,
            -- automatic_installation = true,
        }

        require("mason-tool-installer").setup {
            ensure_installed = {
                "stylua",
                "selene",
                "prettier",
                "delve",
                -- luau-lsp.nvim manages this server after Mason installs it.
                "luau-lsp",
            },
            run_on_start = true,
        }

        -- vim.lsp.on_attach_callback = function(client, bufnr)
        --   vim.lsp.inlay_hint(bufnr, true)
        -- end

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                opts = { buffer = ev.buf }
                local telescope = require "telescope.builtin"

                opts.desc = "Go to definition"
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)

                opts.desc = "Hover documentation"
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)

                opts.desc = "Workspace symbol search"
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)

                opts.desc = "Open diagnostic float"
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)

                -- opts.desc = "Go to next diagnostic"
                -- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                --
                -- opts.desc = "Go to previous diagnostic"
                -- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)

                opts.desc = "Code action"
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)

                opts.desc = "References"
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)

                opts.desc = "Rename symbol"
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)

                opts.desc = "Signature help"
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end,
        })
    end,
}
