# Neovim configuration

Personal Neovim configuration built with [lazy.nvim](https://github.com/folke/lazy.nvim).

## Layout

- `init.lua` loads the core configuration and selected colorscheme.
- `lua/config/` contains editor options, keymaps, autocmds, plugin bootstrap code, and the persisted theme.
- `lua/plugins/` groups focused lazy.nvim specifications by UI, navigation, editing, and coding features.
- `lua/config/theme.lua` is written by the Telescope themes picker and selects the active theme.

The configuration keeps normal and floating windows transparent after any colorscheme change.

## First launch

### Requirements

- Neovim 0.12 or later.
- `git`, used to bootstrap lazy.nvim and install plugins.
- `make`, used to build Telescope's optional `telescope-fzf-native.nvim` extension.
- `ripgrep` (`rg`), required by Telescope's live text search.
- `tree-sitter` CLI 0.26.1 or later and a C compiler, required to install Treesitter parsers.
- The language runtimes required by the tools you choose to install through Mason. This
  configuration installs Lua tooling, Prettier, Delve, and the Luau language server;
  Prettier requires Node.js. Mason reports any additional runtime requirements.

On Debian, install the Treesitter parser build dependencies with:

```sh
sudo apt update
sudo apt install -y build-essential cargo
cargo install tree-sitter-cli --locked
export PATH="$HOME/.cargo/bin:$PATH"
tree-sitter --version
```

Add `export PATH="$HOME/.cargo/bin:$PATH"` to your shell profile if the Cargo bin
directory is not already on `PATH`. After installing or updating Treesitter, run
`:TSUpdate` inside Neovim.

Place this repository at Neovim's standard configuration directory (for example,
`~/.config/nvim` on Linux and macOS) and start Neovim. On the first launch,
lazy.nvim is cloned and installs the declared plugins.

`lazy-lock.json` pins the plugin revisions used by this configuration. Run `:Lazy sync`
after pulling updates to install the locked revisions.

### Network behavior

lazy.nvim checks for plugin updates in the background at startup. Mason also installs
the configured language servers and tools when Neovim starts. Both operations may use
the network and can be adjusted in `lua/config/lazy.lua` and
`lua/plugins/coding/lsp.lua`.
