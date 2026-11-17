-- Run from install.sh after locked plugins have been restored.
require("lazy").load({ plugins = { "LspConfig" } })
local registry = require("mason-registry")
local refreshed = false
local refresh_ok = false
registry.refresh(function(ok)
    refresh_ok = ok
    refreshed = true
end)
assert(
    vim.wait(120000, function()
        return refreshed
    end, 100),
    "Mason registry refresh timed out"
)
assert(refresh_ok, "Mason registry refresh failed")

vim.cmd("MasonToolsInstallSync")
local failures = {}
for _, tool in ipairs(require("config.tools")) do
    local package = registry.get_package(tool.name)
    if not package:is_installed() or package:get_installed_version() ~= tool.version then
        table.insert(failures, tool.name .. "@" .. tool.version)
    end
end
assert(#failures == 0, "Missing or mismatched Mason tools: " .. table.concat(failures, ", "))
print("Mason tools match config.tools")
