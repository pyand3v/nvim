local obsidian_config = require("config.obsidian")
local vault_events = {}

for _, workspace in ipairs(obsidian_config.workspaces) do
    table.insert(vault_events, "BufReadPre " .. workspace.path .. "/**.md")
    table.insert(vault_events, "BufNewFile " .. workspace.path .. "/**.md")
end

local function readable_note_id(title)
    if title == nil or title == "" then
        return tostring(os.time())
    end

    return title:lower():gsub("%s+", "-"):gsub("[^%w%-]", "")
end

return {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    cmd = "Obsidian",
    event = vault_events,
    init = function()
        local group = vim.api.nvim_create_augroup("ObsidianConceal", { clear = true })

        vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
            group = group,
            callback = function(args)
                local buffer_name = vim.api.nvim_buf_get_name(args.buf)

                for _, workspace in ipairs(obsidian_config.workspaces) do
                    if vim.startswith(buffer_name, workspace.path .. "/") then
                        vim.opt_local.conceallevel = 2
                        return
                    end
                end
            end,
            desc = "Enable Obsidian Markdown concealment in configured vaults",
        })
    end,
    keys = {
        { "<leader>on", "<cmd>Obsidian new<cr>", desc = "Obsidian: new note" },
        { "<leader>os", "<cmd>Obsidian quick_switch<cr>", desc = "Obsidian: switch note" },
        { "<leader>of", "<cmd>Obsidian search<cr>", desc = "Obsidian: search notes" },
        { "<leader>od", "<cmd>Obsidian today<cr>", desc = "Obsidian: today" },
        { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Obsidian: backlinks" },
        { "<leader>ot", "<cmd>Obsidian tags<cr>", desc = "Obsidian: tags" },
        { "<leader>ol", "<cmd>Obsidian links<cr>", desc = "Obsidian: links" },
        { "<leader>ow", "<cmd>Obsidian workspace<cr>", desc = "Obsidian: switch workspace" },
        { "<leader>op", "<cmd>Obsidian paste_img<cr>", desc = "Obsidian: paste image" },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "hrsh7th/nvim-cmp",
    },
    opts = {
        legacy_commands = false,
        workspaces = obsidian_config.workspaces,
        notes_subdir = "notes",
        new_notes_location = "notes_subdir",
        note_id_func = readable_note_id,
        link = {
            style = "wiki",
        },
        picker = {
            name = "telescope.nvim",
        },
        completion = {
            min_chars = 2,
            create_new = true,
        },
        daily_notes = {
            folder = "daily",
            date_format = "%Y-%m-%d",
            template = "daily.md",
        },
        templates = {
            folder = "templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
        },
        attachments = {
            folder = "attachments",
        },
        ui = {
            enable = true,
        },
    },
}
