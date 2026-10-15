-- Prefer make (Linux, macOS, MinGW) and fall back to CMake, which uses the
-- Microsoft C++ Build Tools on Windows. Without either, Telescope keeps its
-- built-in sorter instead of failing the build on every sync.
local fzf_build
if vim.fn.executable("make") == 1 then
    fzf_build = "make"
elseif vim.fn.executable("cmake") == 1 then
    fzf_build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install"
end

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "andrew-george/telescope-themes",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = fzf_build,
            cond = fzf_build ~= nil,
        },
    },
    keys = {
        {
            "<leader>pf",
            function()
                require("telescope.builtin").find_files()
            end,
            desc = "Find files in cwd",
        },
        {
            "<leader>gf",
            function()
                require("telescope.builtin").git_files()
            end,
            desc = "Find git files",
        },
        {
            "<leader>ps",
            function()
                require("telescope.builtin").live_grep()
            end,
            desc = "Find string in cwd",
        },
        {
            "<leader>of",
            function()
                require("telescope.builtin").oldfiles()
            end,
            desc = "Find old files",
        },
        {
            "<leader>lr",
            function()
                require("telescope.builtin").lsp_references()
            end,
            desc = "Find LSP references",
        },
        {
            "<leader>ls",
            function()
                require("telescope.builtin").lsp_document_symbols()
            end,
            desc = "Find LSP symbols in current file",
        },
        {
            "<leader>li",
            function()
                require("telescope.builtin").lsp_implementations()
            end,
            desc = "Find LSP implementations",
        },
        { "<leader>th", "<cmd>Telescope themes<cr>", desc = "Theme switcher" },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
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
                        keywords = { "light", "day", "frappe" },
                    },

                    dark_themes = {
                        ignore = false,
                        keywords = { "dark", "night", "black" },
                    },

                    persist = {
                        enabled = true,
                        path = vim.fn.stdpath("config") .. "/lua/config/theme.lua",
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
        })

        -- The native sorter is optional; skip it when it was not built.
        pcall(telescope.load_extension, "fzf")
    end,
}
