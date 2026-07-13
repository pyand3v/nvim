-- Keep the editor background transparent after every colorscheme change.
local transparent_groups = { "Normal", "NormalFloat", "Float" }

local function apply_transparency()
    for _, group in ipairs(transparent_groups) do
        vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
end

local group = vim.api.nvim_create_augroup("SchopenhauerTransparentBackground", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = apply_transparency,
    desc = "Keep colorscheme backgrounds transparent",
})
