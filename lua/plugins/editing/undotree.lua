-- Visualize and navigate the persistent undo history for each file.
return {
    "mbbill/undotree",
    name = "Undotree",
    keys = {
        { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" },
    },
    config = function()
        vim.g.float_diff = true
        vim.g.undotree_WindowLayout = 2
        vim.g.undotree_SetFocusWhenToggle = 1
    end,
}
