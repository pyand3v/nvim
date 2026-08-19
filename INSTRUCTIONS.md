# Neovim Guide

This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) to manage plugins.

## Everyday Neovim

The leader key is `Space`. Split focus uses `Alt+h`, `Alt+j`, `Alt+k`, and `Alt+l`.

Telescope is the general discovery tool:

- `<leader>pf` finds files in the current directory.
- `<leader>ps` searches text in the current directory.
- `<leader>of` lists recently opened files.
- `<leader>gf` searches Git-tracked files.

Completion uses `Ctrl+j` and `Ctrl+k` to move through candidates, `Enter` or `Ctrl+y` to confirm, and `Ctrl+q` to close the menu.

## Plugin Maintenance

After plugin changes, run `:Lazy sync`. Use `:checkhealth` to diagnose provider, LSP, or plugin issues. Confirm the configuration starts cleanly with:

```sh
nvim --headless '+lua print("CONFIG_OK")' +qa
```
