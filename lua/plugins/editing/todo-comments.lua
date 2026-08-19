return {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TodoLocList", "TodoQuickFix", "TodoTelescope" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        {
            "]t",
            function()
                require("todo-comments").jump_next()
            end,
            desc = "Next TODO comment",
        },
        {
            "[t",
            function()
                require("todo-comments").jump_prev()
            end,
            desc = "Previous TODO comment",
        },
        { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Search TODO comments" },
        {
            "<leader>sT",
            "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",
            desc = "Search actionable comments",
        },
    },
    opts = {
        signs = true,
        highlight = {
            comments_only = true,
            keyword = "wide",
        },
    },
}
