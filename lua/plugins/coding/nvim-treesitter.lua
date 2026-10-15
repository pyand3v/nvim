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

-- Go's bundled indenter handles its syntax more reliably than Tree-sitter's
-- generic indentation query when using the `=` operator.
local tree_sitter_indent_exclusions = {
    go = true,
}

local function has_c_compiler()
    if vim.env.CC and vim.env.CC ~= "" then
        return true
    end
    for _, compiler in ipairs({ "cc", "gcc", "clang", "cl" }) do
        if vim.fn.executable(compiler) == 1 then
            return true
        end
    end
    -- tree-sitter locates MSVC through vswhere even when cl.exe is not on PATH.
    local program_files = vim.env["ProgramFiles(x86)"]
    return program_files ~= nil
        and vim.uv.fs_stat(program_files .. "/Microsoft Visual Studio/Installer/vswhere.exe") ~= nil
end

-- Parsers are compiled locally, so only start an install when the toolchain is
-- present; otherwise every startup would print one error per parser.
local function install_parsers()
    local installed = require("nvim-treesitter").get_installed()
    local missing = vim.tbl_filter(function(language)
        return not vim.list_contains(installed, language)
    end, languages)
    if #missing == 0 then
        return true
    end

    local missing_tools = {}
    if vim.fn.executable("tree-sitter") == 0 then
        table.insert(missing_tools, "tree-sitter CLI (:MasonInstall tree-sitter-cli)")
    end
    if not has_c_compiler() then
        table.insert(missing_tools, "a C compiler")
    end
    if #missing_tools > 0 then
        return false, missing_tools
    end

    require("nvim-treesitter").install(missing)
    return true
end

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    name = "Treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
        -- Mason prepends its bin directory to PATH, where tree-sitter-cli lives.
        "mason-org/mason.nvim",
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            branch = "main",
        },
        "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
        require("nvim-treesitter").setup()

        local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })
        local ok, missing_tools = install_parsers()
        if not ok then
            vim.notify(
                "Treesitter parsers not installed; missing " .. table.concat(missing_tools, " and "),
                vim.log.levels.WARN
            )
            -- Retry once Mason has finished installing tree-sitter-cli.
            vim.api.nvim_create_autocmd("User", {
                group = group,
                pattern = "MasonToolsUpdateCompleted",
                once = true,
                callback = function()
                    install_parsers()
                end,
                desc = "Install Treesitter parsers after Mason tools",
            })
        end

        vim.api.nvim_create_autocmd("FileType", {
            group = group,
            callback = function(args)
                local language = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
                if not language or not vim.treesitter.language.add(language) then
                    return
                end

                vim.treesitter.start(args.buf, language)
                if not tree_sitter_indent_exclusions[vim.bo[args.buf].filetype] then
                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
                vim.keymap.set({ "n", "x" }, "<C-space>", function()
                    vim.treesitter.select("parent")
                end, { buffer = args.buf, desc = "Expand Treesitter selection" })
            end,
            desc = "Enable Treesitter highlighting and indentation",
        })
    end,
}
