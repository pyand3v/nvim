return {
    {
        "0xstepit/flow.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            require("flow").setup{
                transparent = true,
                fluo_color = "pink",
                mode = "normal",
                aggressive_spell = false,
            }
            -- Set transparency for all groups
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            vim.api.nvim_set_hl(0, "Float", { bg = "none" })
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = { style = "storm" },
        config = function()
            require("tokyonight").setup{
                transparent = true,
            }
            -- Set transparency for all groups
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            vim.api.nvim_set_hl(0, "Float", { bg = "none" })
        end,
    },
    {
        'AlexvZyl/nordic.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('nordic').setup({
                transparent_bg = true,
                transparent_background = true,
                transparent = {
                    bg = false,
                    float = false,
                },
            })
            -- Set transparency for all groups
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            vim.api.nvim_set_hl(0, "Float", { bg = "none" })
        end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                dark_variant = 'main',
                disable_background = true,
            })
            -- Set transparency for all groups
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            vim.api.nvim_set_hl(0, "Float", { bg = "none" })
        end
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require('catppuccin').setup({
                transparent_background = true,
            })
            -- Set transparency for all groups
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            vim.api.nvim_set_hl(0, "Float", { bg = "none" })
        end
    },
    {
        'shaunsingh/nord.nvim',
        config = function()
            vim.g.nord_transparent = true
            -- Set transparency for all groups
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            vim.api.nvim_set_hl(0, "Float", { bg = "none" })
        end
    },
    {
        "Mofiqul/dracula.nvim",
        config = function()
            require('dracula').setup()
            -- Set transparency for all groups
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            vim.api.nvim_set_hl(0, "Float", { bg = "none" })
        end
    },
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require('cyberdream').setup({
                transparent_background = true,
            })
            -- Set transparency for all groups
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            vim.api.nvim_set_hl(0, "Float", { bg = "none" })
        end
    }
}
