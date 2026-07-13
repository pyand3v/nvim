-- Visualize and navigate the persistent undo history for each file.
return {
  "mbbill/undotree",
  name = "Undotree",
  config = function()
    -- Store undo files under Neovim's cache directory.
    vim.opt.undodir = os.getenv "HOME" .. "/.cache/nvim/.undodir"
    vim.opt.undofile = true
    vim.g.float_diff = true
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })
  end,
}
