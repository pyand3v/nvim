return {
    {
        'stevearc/oil.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
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

            vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })
            vim.keymap.set("n", "<leader>-", require("oil").toggle_float, { desc = "Toggle floating file browser" })
        end,
    },
}
