-- Fails Neovim's startup when this configuration or a plugin's setup reports an error.
-- Usage: nvim --headless --cmd "luafile .github/scripts/check-startup.lua" init.lua
-- Loaded with `--cmd` so it runs before init.lua and sees every error raised during startup.
local errors = {}

-- lazy.nvim reports failing plugin specs and `config` functions through vim.notify instead of raising
local notify = vim.notify
vim.notify = function(message, level, options)
    if level == vim.log.levels.ERROR then
        table.insert(errors, message)
    end
    return notify(message, level, options)
end

local function finish()
    if vim.v.errmsg ~= "" then
        table.insert(errors, vim.v.errmsg)
    end

    if #errors == 0 then
        io.write("Startup finished without errors\n")
        vim.cmd("qall!")
        return
    end

    for _, message in ipairs(errors) do
        io.write(("::error title=Startup error::%s\n"):format(message:gsub("\n", "%%0A")))
    end
    vim.cmd("cquit 1")
end

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        -- Lazy-loaded plugins only run their setup on their trigger events, so load all of them to cover those too.
        -- `:Lazy` is missing when init.lua failed before lazy.nvim was set up, which must still end the run.
        local ok, message = pcall(vim.cmd, "Lazy! load all")
        if not ok then
            table.insert(errors, message)
        end
        -- Leave time for scheduled callbacks to run; Mason's background installs are not waited on
        vim.defer_fn(finish, 2000)
    end,
})
