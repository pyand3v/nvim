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
- `make` or `cmake`, used to build Telescope's optional `telescope-fzf-native.nvim`
  extension. Without either, the extension is skipped and Telescope uses its built-in sorter.
- `ripgrep` (`rg`), required by Telescope's live text search.
- `tree-sitter` CLI 0.26.1 or later and a C compiler, required to install Treesitter parsers.
  Mason installs `tree-sitter-cli` automatically, so only the compiler must come from the
  system. Until both are available, startup shows a single warning instead of building.
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

On Windows, install the Microsoft C++ Build Tools (the "Desktop development with C++"
workload), which Treesitter finds without any `PATH` changes, plus CMake for the
Telescope extension:

```powershell
winget install Microsoft.VisualStudio.2022.BuildTools --override "--add Microsoft.VisualStudio.Workload.VCTools --includeRecommended --passive"
winget install Kitware.CMake BurntSushi.ripgrep.MSVC
```

The clipboard works out of the box on Windows (`win32yank.exe` ships with Neovim) and
under WSLg. On Linux, install `wl-clipboard` (Wayland) or `xclip` (X11).

Place this repository at Neovim's standard configuration directory (`~/.config/nvim`
on Linux and macOS, `%LOCALAPPDATA%\nvim` on Windows) and start Neovim. On the first launch,
lazy.nvim is cloned and installs the declared plugins.

`lazy-lock.json` pins the plugin revisions used by this configuration. Run `:Lazy sync`
after pulling updates to install the locked revisions.

### Network behavior

lazy.nvim checks for plugin updates in the background at startup. Mason also installs
the configured language servers and tools when Neovim starts. Both operations may use
the network and can be adjusted in `lua/config/lazy.lua` and
`lua/plugins/coding/lsp.lua`.
