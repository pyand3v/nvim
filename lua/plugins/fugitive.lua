return {
  "tpope/vim-fugitive",
  name = "Fugitive",
  config = function()
    vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "Git status" })
    vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "File blame" })
  end,
}
