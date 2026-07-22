-- Add named vaults here. Each path must point at the root of an Obsidian vault.
local home_directory = vim.fn.expand("~")

return {
    workspaces = {
        {
            name = "personal",
            path = home_directory .. "/Documents/Obsidian",
        },
    },
}
