local languages = {
    "bash",
    "c",
    "cpp",
    "css",
    "diff",
    "html",
    "javascript",
    "json",
    "jsonnet",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "regex",
    "scss",
    "svelte",
    "toml",
    "typescript",
    "tsx",
    "vim",
    "vimdoc",
    "yaml",
    "go",
    "gomod",
    "gowork",
    "gosum",
    "rust",
    "solidity",
    "dockerfile",
    "zig",
}

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    name = "Treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            branch = "main",
        },
        "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
        require("nvim-treesitter").setup()
        require("nvim-treesitter").install(languages)

        local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            group = group,
            callback = function(args)
                local language = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
                if not language or not vim.treesitter.language.add(language) then
                    return
                end

                vim.treesitter.start(args.buf, language)
                vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                vim.keymap.set({ "n", "x" }, "<C-space>", function()
                    vim.treesitter.select("parent")
                end, { buffer = args.buf, desc = "Expand Treesitter selection" })
            end,
            desc = "Enable Treesitter highlighting and indentation",
        })
    end,
}
