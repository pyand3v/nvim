# Neovim configuration

Personal Neovim configuration built with [lazy.nvim](https://github.com/folke/lazy.nvim).

## Layout

- `init.lua` loads the core configuration and selected colorscheme.
- `lua/schopenhauer/` contains editor options, keymaps, and plugin bootstrap code.
- `lua/plugins/` contains one lazy.nvim plugin specification per feature.
- `lua/colorscheme.lua` is written by the Telescope themes picker and selects the active theme.

The configuration keeps normal and floating windows transparent after any colorscheme change.

## First launch

Start Neovim normally. lazy.nvim is cloned automatically when it is not installed, then it installs the declared plugins.
