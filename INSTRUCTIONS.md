# Neovim and Obsidian Guide

This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugins and [obsidian.nvim](https://github.com/obsidian-nvim/obsidian.nvim) for Markdown-based knowledge management. The first workspace is the `personal` vault at `~/Documents/Obsidian`.

## Start Here (Index)

1. [Everyday Neovim](#everyday-neovim) — leader key, windows, searching, completion, and plugin maintenance.
2. [Open and Organize the Vault](#open-and-organize-the-vault) — vault layout, creating notes, and templates.
3. [Find and Connect Notes](#find-and-connect-notes) — search, links, tags, backlinks, and completion.
4. [Daily Notes and Attachments](#daily-notes-and-attachments) — dated journals and clipboard images.
5. [Obsidian Keymap Reference](#obsidian-keymap-reference) — all `<leader>o` mappings and in-note actions.
6. [Manage Multiple Vaults](#manage-multiple-vaults) — add and switch named workspaces.
7. [Install, Update, and Troubleshoot](#install-update-and-troubleshoot) — health checks and common prerequisites.

## Everyday Neovim

The leader key is `Space`, so `<leader>os` means press `Space`, then `o`, then `s` in Normal mode. Split focus uses `Alt+h`, `Alt+j`, `Alt+k`, and `Alt+l`.

Telescope is the general discovery tool:

- `<leader>pf` finds files in the current directory.
- `<leader>ps` searches text in the current directory.
- `<leader>of` lists recently opened files.
- `<leader>gf` searches Git-tracked files.

Completion uses `Ctrl+j` and `Ctrl+k` to move through candidates, `Enter` or `Ctrl+y` to confirm, and `Ctrl+q` to close the menu. In vault notes, typing `[[`, `#`, or `[^` offers Obsidian completion.

## Open and Organize the Vault

Open the vault with `nvim ~/Documents/Obsidian`, or open a note directly. Its practical layout is:

```text
~/Documents/Obsidian/
├── notes/        # Regular notes created by Obsidian.nvim
├── daily/        # One Markdown file per day
├── templates/    # Reusable note fragments
└── attachments/  # Images pasted from the clipboard
```

Use `<leader>on` to create a regular note. Names become lowercase, hyphen-separated filenames, so a note titled `Reading List` is stored as `reading-list.md`. New regular notes go in `notes/`.

Use `:Obsidian new_from_template` to create a note from a template, or `:Obsidian template` to insert a template into the current note. Template variables such as `{{title}}`, `{{date}}`, and `{{time}}` are expanded by the plugin.

## Find and Connect Notes

Write `[[` and select a note to create a wiki link. Press `Enter` on a link to follow it; on a tag it opens matching notes; and on a task checkbox it toggles the checkbox. Use `]o` and `[o` to move to the next and previous link in the current note.

Use `<leader>os` for a quick note switcher and `<leader>of` for full-text vault search. `<leader>ot` finds tags, `<leader>ob` finds notes that link to the current note, and `<leader>ol` lists links from the current note.

For refactors, use `:Obsidian rename` while editing a note; it updates backlinks across the vault. Save all affected buffers after the operation.

## Daily Notes and Attachments

`<leader>od` opens or creates today’s note at `daily/YYYY-MM-DD.md` using `templates/daily.md`. `:Obsidian today -1` opens yesterday; `:Obsidian tomorrow` and `:Obsidian yesterday` use working-day behavior.

Copy an image, place the cursor in a vault note, then press `<leader>op`. The image is saved in `attachments/` and a Markdown image link is inserted. Linux image pasting needs `xclip` on X11 or `wl-clipboard` on Wayland.

## Obsidian Keymap Reference

| Mapping | Action |
| --- | --- |
| `<leader>on` | Create a note |
| `<leader>os` | Quick-switch notes |
| `<leader>of` | Search vault text |
| `<leader>od` | Open/create today’s daily note |
| `<leader>ob` | Show backlinks |
| `<leader>ot` | Browse tags |
| `<leader>ol` | List links in the current note |
| `<leader>ow` | Select a workspace |
| `<leader>op` | Paste a clipboard image |
| `Enter` | Follow link, browse tag, toggle checkbox, or fold heading |
| `]o` / `[o` | Next / previous link |

Type `:Obsidian` and press `Tab` to browse every available context-sensitive subcommand. `:Obsidian help` opens the plugin’s installed help.

## Manage Multiple Vaults

Named vaults live in `lua/config/obsidian.lua`. Add an entry to the `workspaces` table for each additional vault:

```lua
{
    name = "work",
    path = home_directory .. "/Documents/Work-Obsidian",
},
```

Restart Neovim after changing the registry, then use `<leader>ow` or `:Obsidian workspace` to switch vaults. Give each workspace a unique name and point `path` at the vault root—the directory containing its `.obsidian` folder when it is also used with the Obsidian app.

## Install, Update, and Troubleshoot

After plugin changes, run `:Lazy sync`; this installs the pinned stable release and updates `lazy-lock.json`. Check the integration with `:checkhealth obsidian` and `:Obsidian check`.

Obsidian.nvim requires Neovim 0.10 or later and ripgrep for search and completion. Confirm dependencies with `nvim --version` and `rg --version`. If a picker or completion feature is unavailable, first run `:Lazy sync`, restart Neovim, then repeat the health check.
