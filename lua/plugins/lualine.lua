return {
    "nvim-lualine/lualine.nvim",
    name = "Lualine",
    enabled = true,
    config = function()
        local clients_lsp = function()
            local bufnr = vim.api.nvim_get_current_buf()
            local clients = vim.lsp.get_clients(bufnr)

            if next(clients) == nil then
                return "No LSP"
            end

            local clients_ = {}
            for _, client in pairs(clients) do
                table.insert(clients_, client.name)
            end
            return "LSP: " .. table.concat(clients_, "|")
        end
        require("lualine").setup {
            options = {
                icons_enabled = false,
                theme = vim.g.colors_name,
                -- No separators.
                component_separators = "│",
                section_separators = "",
                -- -- Lualine bar only under focused pane.
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            -- Displayed at the bottom.
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_x = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            -- Displayed at the top.
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {},
        }
    end,
}
