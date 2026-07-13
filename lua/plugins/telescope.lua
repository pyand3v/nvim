return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    name = "Telescope",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "andrew-george/telescope-themes",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "folke/todo-comments.nvim",
    },
    config = function()
        local telescope = require "telescope"
        local actions = require "telescope.actions"
        telescope.load_extension "fzf"

        telescope.setup {
            defaults = {
                layout_strategy = "vertical",
                path_display = { "full" },
                fuzzy = true,
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-l>"] = actions.select_default,
                        ["<C-y>"] = actions.select_default,
                        ["<C-c>"] = actions.close,
                        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                    },
                },
            },
            extensions = {
                themes = {
                    layout_config = {
                        horizontal = {
                            width = 0.8,
                            height = 0.7,
                        },
                    },

                    enable_previewer = false,
                    enable_live_preview = true,
                    light_themes = {
                        ignore = true,
                        keywords = { "light", "day", "frappe" }
                    },

                    dark_themes = {
                        ignore = false,
                        keywords = { "dark", "night", "black" }
                    },

                    persist = {
                        enabled = true,
                        path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua"
                    },
                    mappings = {
                        down = "<C-n>",
                        up = "<C-p>",
                        accept = "<CR>",
                    },
                },
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
            pickers = {
                find_files = {
                    show_line = true,
                    previewer = false,
                    disable_devicons = false,
                },
                live_grep = {
                    layout_config = {
                        width = 0.90,
                    },
                    show_line = false,
                    disable_devicons = true,
                },
                oldfiles = {
                    previewer = false,
                    disable_devicons = true,
                },
                lsp_references = {
                    layout_config = {
                        width = 0.90,
                    },
                    show_line = false,
                    disable_devicons = true,
                },
                lsp_implementations = {
                    layout_config = {
                        width = 0.90,
                    },
                    show_line = false,
                    disable_devicons = true,
                },
                lsp_document_symbols = {
                    layout_strategy = "horizontal",
                    layout_config = {
                        preview_width = 0.6,
                        width = 0.90,
                    },
                    show_line = false,
                    disable_devicons = true,
                },
            },
        }

        local builtin = require "telescope.builtin"

        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files in cwd" })
        vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Find git files" })
        vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "Find string in cwd" })
        vim.keymap.set("n", "<leader>of", builtin.oldfiles, { desc = "Find old files" })
        vim.keymap.set("n", "<leader>lr", builtin.lsp_references, { desc = "Find lsp references" })
        vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "Find lsp symbols in the current file" })
        vim.keymap.set("n", "<leader>li", builtin.lsp_implementations, { desc = "Find LSP implementations" })
        vim.keymap.set("n", "<leader>th", ":Telescope themes<CR>", { noremap = true, silent = true, desc = "Theme switcher" })
    end,
}
