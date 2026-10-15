# Repository Guidelines

## Project Structure & Module Organization

This is a Lua-based Neovim configuration managed with `lazy.nvim`.

- `init.lua` is the startup entry point; it loads core configuration and the saved colorscheme.
- `lua/config/` contains editor-wide behavior: keymaps (`keymaps.lua`), options (`options.lua`), plugin bootstrap (`lazy.lua`), and autocmds such as background transparency (`autocmds.lua`). `init.lua` in this directory fixes their load order.
- `lua/config/lsp/` holds shared LSP settings: the server list (`servers.lua`), buffer keymaps (`keymaps.lua`), and diagnostics (`diagnostics.lua`).
- `lua/plugins/` contains lazy.nvim specifications grouped by area (`ui/`, `navigation/`, `editing/`, `coding/`), generally one file per feature (for example, `navigation/telescope.lua` or `coding/completion.lua`). Each file must return a plugin spec or list of specs.
- `lua/config/theme.lua` stores the active theme and is rewritten by the Telescope theme picker.
- `lazy-lock.json` pins plugin revisions; update it only when intentionally changing plugin versions.

## Build, Test, and Development Commands

There is no build step or automated test suite. Use Neovim itself to validate configuration changes:

```sh
nvim --headless '+lua print("CONFIG_OK")' +qa
nvim
```

The first command checks startup without opening a UI; the second is the normal manual smoke test. After changing plugin declarations, open Neovim and run `:Lazy sync`. Use `:checkhealth` when diagnosing provider, LSP, or plugin issues.

## Coding Style & Naming Conventions

Use Lua with four-space indentation, double-quoted strings, and trailing commas in multiline tables. Prefer descriptive local names and focused plugin files named after the feature or plugin (`nvim-treesitter.lua`, `undotree.lua`). Use `vim.keymap.set` with a `desc` for user-facing mappings. Comments should explain intent or a non-obvious tradeoff; remove commented-out code rather than leaving it in place.

`stylua` and `selene` are installed through Mason. Run `:Mason` to install or update them, and format Lua with StyLua before committing when available.

## Testing Guidelines

Manually test the behavior affected by a change: open relevant filetypes for LSP and completion changes, invoke keymaps after remapping them, and switch colorschemes after theme changes. Keep startup free of Lua errors and warnings caused by this repository.

## Commit & Pull Request Guidelines

Recent commits use concise, imperative summaries such as `Fix nord.nvim` or `Remove colorcolumn`. Keep each commit narrowly scoped. Pull requests should state the user-visible effect, list validation performed, link relevant issues when applicable, and include screenshots for dashboard, statusline, or theme changes.
