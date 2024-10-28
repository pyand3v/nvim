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
        -- we need to configure both options and keymaps inside config because:
        -- - options are configured using telescope actions
        -- - keymaps are configured using telescope builtin

        local telescope = require "telescope"
        local actions = require "telescope.actions"
        local themes = require "telescope.themes"
        local builtin_schemes = require("telescope._extensions.themes").builtin_schemes
        telescope.load_extension "fzf"

        telescope.setup {
            defaults = {
                layout_strategy = "vertical",
                path_display = { "full" },
                fuzzy = true,
                mappings = {
                    i = {
                        -- Movements
                        ["<C-k>"] = actions.move_selection_previous, -- move up in Results
                        ["<C-j>"] = actions.move_selection_next, -- move down in Results
                        -- Actions
                        ["<C-l>"] = actions.select_default,
                        ["<C-y>"] = actions.select_default,
                        ["<C-c>"] = actions.close, -- close window
                        -- ["<C-c>"] = actions.delete_buffer, -- close buffer
                        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                    },
                },
            },
            extensions = {
                themes = {
                    -- you can add regular telescope config
                    -- that you want to apply on this picker only
                    layout_config = {
                        horizontal = {
                            width = 0.8,
                            height = 0.7,
                        },
                    },

                    -- extension specific config

                    -- (boolean) -> show/hide previewer window
                    enable_previewer = false,

                    -- (boolean) -> enable/disable live preview
                    enable_live_preview = true,

                    -- all builtin themes are ignored by default
                    -- (list) -> provide table of theme names to overwrite builtins list
                    -- (table)
                    -- (boolean) ignore -> toggle ignore light themes
                    -- (list) keywords -> list of keywords that would identify as light theme
                    light_themes = {
                        ignore = true,
                        keywords = { "light", "day", "frappe" }
                    },

                    -- (table)
                    -- (boolean) ignore -> toggle ignore dark themes
                    -- (list) keywords -> list of keywords that would identify as dark theme
                    dark_themes = {
                        ignore = false,
                        keywords = { "dark", "night", "black" }
                    },

                    persist = {
                        -- enable persisting last theme choice
                        enabled = true,

                        -- override path to file that execute colorscheme command
                        path = vim.fn.stdpath("config") .. "/lua/colorscheme.lua"
                    },
                    mappings = {
                        -- for people used to other mappings
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
                    -- theme = "dropdown", -- for some reason this is not working
                    show_line = true,
                    previewer = false,
                    disable_devicons = false,
                },
                live_grep = {
                    layout_config = {
                        width = 0.90,
                    },
                    -- theme = "dropdown",
                    show_line = false,
                    disable_devicons = true,
                },
                oldfiles = {
                    -- theme = "dropdown",
                    previewer = false,
                    disable_devicons = true,
                },
                lsp_references = {
                    layout_config = {
                        width = 0.90,
                    },
                    -- theme = "dropdown",
                    show_line = false,
                    disable_devicons = true,
                },
                lsp_implementations = {
                    layout_config = {
                        width = 0.90,
                    },
                    -- theme = "dropdown",
                    show_line = false,
                    disable_devicons = true,
                },
                lsp_document_symbols = {
                    layout_strategy = "horizontal", -- Use horizontal layout here
                    layout_config = {
                        preview_width = 0.6, -- Preview on the right, taking 60% of the width
                        width = 0.90, -- Adjust the total width
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
        vim.keymap.set("n", "<leader>li", builtin.lsp_implementations, { desc = "Find the lsp implemention in the current file" })
        vim.keymap.set("n", "<leader>th", ":Telescope themes<CR>", {noremap = true, silent = true, desc = "Theme Switcher"})
    end,
}
