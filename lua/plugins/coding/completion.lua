return {
    "hrsh7th/nvim-cmp",
    name = "Completion",
    event = "InsertEnter",
    dependencies = {
        -- Sources
        "hrsh7th/cmp-buffer", -- Words from the current buffer.
        "hrsh7th/cmp-path", -- Filesystem paths.
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp-signature-help",

        -- Snippets
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind.nvim",

        "windwp/nvim-autopairs",
    },
    config = function()
        local cmp_status_ok, cmp = pcall(require, "cmp")
        if not cmp_status_ok then
            vim.api.nvim_err_writeln("CMP module not found or failed to load")
            return
        end

        local lspkind = require("lspkind")
        local luasnip = require("luasnip")

        -- Insert matching parentheses after completing a callable item.
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

        require("luasnip.loaders.from_vscode").lazy_load()

        -- Start completion only when the cursor follows a non-whitespace character.
        local function has_words_before()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local sources = {
            { name = "luasnip", max_item_count = 5 },
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
            { name = "buffer", max_item_count = 5 },
            { name = "path", max_item_count = 5 },
            { name = "nvim_lsp_signature_help" },
        }

        -- Selecting an item only highlights it until it is confirmed.
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({

            -- Delegate snippet expansion to LuaSnip.
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            formatting = {
                expandable_indicator = true,
                format = lspkind.cmp_format({
                    mode = "text",
                    with_text = true,
                    maxwidth = 50,
                    ellipsis_char = "...",
                    menu = {
                        luasnip = "[LSNIP]",
                        nvim_lsp = "[NLSP]",
                        nvim_lua = "[NLUA]",
                        buffer = "[BUF]",
                        path = "[PATH]",
                        nvim_lsp_signature_help = "[SIG]",
                    },
                }),
            },
            mapping = {
                -- Insert, command, and select mode mappings.
                -- Scroll completion documentation.
                ["<C-b>"] = cmp.mapping.scroll_docs(4),
                ["<C-f>"] = cmp.mapping.scroll_docs(-4),

                -- Move through completion candidates.
                ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),

                -- Confirm or close the completion menu.
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-q>"] = cmp.mapping.close(),

                -- Prefer completion, then snippet navigation, then normal editing.
                ["<C-n>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { "i", "c", "s" }),
                ["<C-p>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "c", "s" }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    local col = vim.fn.col(".") - 1
                    if cmp.visible() then
                        cmp.confirm({ select = true })
                    elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
                        fallback()
                    else
                        cmp.complete()
                    end
                end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item(cmp_select)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },
            sources = cmp.config.sources(sources),
        })
    end,
}
