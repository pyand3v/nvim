return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<leader>pv", "<cmd>Oil<cr>", desc = "Open parent directory" },
            {
                "<leader>-",
                function()
                    require("oil").toggle_float()
                end,
                desc = "Toggle floating file browser",
            },
        },
        opts = function()
            return {
                columns = { "icon" },
                view_options = {
                    show_hidden = true,
                },
            }
        end,
        config = function(_, opts)
            require("oil").setup(opts)
        end,
    },
}
