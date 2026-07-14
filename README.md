# Neovim configuration

Personal Neovim configuration built with [lazy.nvim](https://github.com/folke/lazy.nvim).

## Layout

- `init.lua` loads the core configuration and selected colorscheme.
- `lua/config/` contains editor options, keymaps, autocmds, plugin bootstrap code, and the persisted theme.
- `lua/plugins/` groups focused lazy.nvim specifications by UI, navigation, editing, and coding features.
- `lua/config/theme.lua` is written by the Telescope themes picker and selects the active theme.

The configuration keeps normal and floating windows transparent after any colorscheme change.

## First launch

Start Neovim normally. lazy.nvim is cloned automatically when it is not installed, then it installs the declared plugins.
