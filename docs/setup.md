# Ubuntu setup and reproducibility

Place or symlink this checkout at `~/.config/nvim` (or the directory selected by
`XDG_CONFIG_HOME` and `NVIM_APPNAME`). The installer refuses to operate on a different
active config. It never replaces an existing config or edits shell profiles.

Install Neovim 0.12+ and [mise](https://mise.jdx.dev/installing-mise.html) first.
For example, the official standalone mise installer can install a specific release:

```sh
curl -fsSL https://mise.run | MISE_VERSION=v2026.11.2 sh
export PATH="$HOME/.local/bin:$PATH"
```

Review the upstream installation method before running a downloaded script. Then run:

```sh
./scripts/install.sh --apt
```

The optional `--apt` installs Ubuntu prerequisites using sudo. Without it, install
those prerequisites yourself. The script checks for mise, installs the exact Node,
npm, Go, and Rust versions in `mise.toml`, and runs provisioning under `mise exec`.
It does not modify shell profiles. This uses network access and writes to mise's and
Neovim's user data directories. Re-running it reconciles installed Mason versions,
including downgrades, without removing unrelated packages.

Mise does not automatically apply this config's runtimes when Neovim is opened from
another project. Activate mise in your shell following its [shell setup guide](https://mise.jdx.dev/shell-setup.html)
to use each project's own settings, or launch from this directory with `mise exec -- nvim`.
Tools such as language servers may need runtimes on PATH during normal editing too.
Install those runtimes globally through mise, or configure them per project.
Language project runtimes (including Zig), Roblox Studio, and Rojo are separate.

## What is pinned

- `mise.toml`: exact Node, npm, Go, and Rust versions used during provisioning.
- `lazy-lock.json`: plugin revisions. `:Lazy restore` restores them; `:Lazy update`
  intentionally changes them. The installer uses restore, not sync/update.
- `lua/config/tools.lua`: exact Mason package versions, initially captured from the
  installed packages, with CodeLLDB added from the local registry. The `lsp` fields
  record server identifiers; mason-lspconfig supplies the actual activation mapping.
- `lua/plugins/coding/mason.lua`: a fixed Mason registry release, so installation
  recipes do not drift independently of package versions. Update it deliberately
  when adding packages or versions absent from that snapshot.
- Mason installation is explicit: `:Lazy load LspConfig`, then
  `:MasonToolsInstallSync`, or use the installer. Normal startup does not install
  Mason packages. The installer additionally checks every installed version and
  exits unsuccessfully on missing tools or mismatches.

This is version-controlled provisioning, not a bit-for-bit environment lock. Ubuntu
packages, other runtimes, transitive package dependencies,
Neovim itself, and Tree-sitter parser downloads are not all pinned here. Upstream
artifacts must remain available. For an immutable environment, also pin the Ubuntu
image/repositories, Neovim version, and downloaded artifacts.

## Updating deliberately

1. Change selected versions in `lua/config/tools.lua` and the registry snapshot in
   `lua/plugins/coding/mason.lua` if needed. Use Mason's package version
   spelling, including a leading `v` where required.
2. Run `./scripts/install.sh` and inspect any Mason failures in `:MasonLog`.
3. Run `:Lazy update` only when upgrading plugins; review `lazy-lock.json`.
4. Run `:TSUpdate` when intentionally refreshing parsers.
5. Run the checks below and smoke-test affected languages before committing.

```sh
bash -n scripts/install.sh scripts/install-config.sh
~/.local/share/nvim/mason/bin/stylua --check .
~/.local/share/nvim/mason/bin/selene .
nvim --headless --cmd 'luafile .github/scripts/check-startup.lua' init.lua
```

Mason's bin directory is added inside Neovim, not to your shell PATH. Adapt the paths
above if using a different data directory. Use `:checkhealth`, `:checkhealth vim.lsp`,
`:ConformInfo`, `:Mason`, and `:MasonLog` to diagnose problems. CI checks plugin startup
on Ubuntu and Windows; this provisioning script supports Ubuntu only and CI does
not currently validate the complete Mason provisioning process.
