-- Keep the same block cursor in every mode.
vim.opt.guicursor = ""

-- Line numbers and indentation.
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

-- Persist undo history, but never create swap or backup files.
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.autoread = true
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undodir"
vim.opt.undofile = true

-- Search feedback and UI responsiveness.
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- WSL may expose a Wayland display even when wl-copy cannot reach its socket.
-- Use the Windows clipboard directly instead of Neovim's auto-detected provider.
if (vim.env.WSL_INTEROP or vim.env.WSL_DISTRO_NAME)
    and vim.fn.executable("clip.exe") == 1
    and vim.fn.executable("powershell.exe") == 1
then
    vim.g.clipboard = {
        name = "WslClipboard",
        copy = {
            ["+"] = { "clip.exe" },
            ["*"] = { "clip.exe" },
        },
        paste = {
            ["+"] = { "powershell.exe", "-NoProfile", "-Command", "Get-Clipboard -Raw" },
            ["*"] = { "powershell.exe", "-NoProfile", "-Command", "Get-Clipboard -Raw" },
        },
        cache_enabled = 0,
    }
end
