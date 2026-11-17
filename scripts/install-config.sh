#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."
nvim --headless -i NONE '+lua if vim.fn.has("nvim-0.12") == 0 then vim.api.nvim_err_writeln("Neovim 0.12+ required"); vim.cmd("cquit 1") end' '+Lazy! restore' +qa
timeout 30m nvim --headless -i NONE \
    '+lua local ok, err = pcall(dofile, "scripts/install-tools.lua"); if not ok then vim.api.nvim_err_writeln(tostring(err)); vim.cmd("cquit 1") end' +qa
nvim --headless -i NONE \
    '+lua local ok, err = pcall(function() assert(require("nvim-treesitter").install({ "c", "cpp" }):wait(300000), "C/C++ parser installation failed") end); if not ok then vim.api.nvim_err_writeln(tostring(err)); vim.cmd("cquit 1") end' +qa
nvim --headless -i NONE --cmd 'luafile .github/scripts/check-startup.lua' init.lua
echo "Setup complete. See docs/runbook.md."
