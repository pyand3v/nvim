return {
    {
        "0xstepit/flow.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            require("flow").setup{
                transparent = true, -- Set transparent background.
                fluo_color = "pink", --  Fluo color: pink, yellow, orange, or green.
                mode = "normal", -- Intensity of the palette: normal, bright, desaturate, or dark. Notice that dark is ugly!
                aggressive_spell = false, -- Display colors for spell check.
            }
        end,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        opts = { style = "storm" },
        config = function()
            require("tokyonight").setup{
                transparent = true, -- Set transparent background.
            }
        end,
    },
    {
        'AlexvZyl/nordic.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('nordic').setup {
            transparent_bg = true,
            }
            vim.cmd([[colorscheme nordic]])
        end
    }
}
