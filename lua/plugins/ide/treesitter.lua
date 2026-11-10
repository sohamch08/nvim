return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")
        ts.setup({})

        -- Keep custom parsers pinned together with their upstream queries.
        local function register_mutt_parsers()
            local parsers = require("nvim-treesitter.parsers")
            local revisions = {
                muttrc = "748101a399fba5041a6f4e101ee2a20b2347d079",
                expando = "70a7c2716208e6b9036620564fdb9001740b8a18",
            }
            for lang, revision in pairs(revisions) do
                parsers[lang] = {
                    install_info = {
                        url = "https://github.com/neomutt/tree-sitter-" .. lang,
                        revision = revision,
                        queries = "queries",
                    },
                }
            end
        end

        register_mutt_parsers()
        vim.api.nvim_create_autocmd("User", {
            group = vim.api.nvim_create_augroup("MuttTreesitterParsers", { clear = true }),
            pattern = "TSUpdate",
            callback = register_mutt_parsers,
        })
        vim.treesitter.language.register("muttrc", { "muttrc", "neomuttrc" })

        ts.install({
            "bash",
            "muttrc",
            "expando",
            "c",
            "diff",
            "html",
            "javascript",
            "typescript",
            "tsx",
            "lua",
            "luadoc",
            "markdown",
            "markdown_inline",
            "query",
            "vim",
            "vimdoc",
            "regex",
            "gitignore",
            "toml",
            "json",
            "yaml",
            "make",
            "cmake",
            "python",
            "css",
            "latex",
            "bibtex",
            "git_config",
            "gitcommit",
            "rasi",
            "typst",
        })

        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup(
                "TreesitterSetup",
                { clear = true }
            ),
            callback = function(args)
                -- Starting without highlight queries disables syntax without replacing it.
                local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
                if not lang then
                    return
                end
                local ok, highlights = pcall(vim.treesitter.query.get, lang, "highlights")
                if not ok or not highlights then
                    return
                end

                -- Keep normal syntax if no parser is installed.
                if not pcall(vim.treesitter.start, args.buf) then
                    return
                end

                -- The custom muttrc parser does not provide indentation queries.
                if lang == "muttrc" then
                    return
                end

                if vim.bo[args.buf].filetype ~= "ruby" then
                    vim.bo[args.buf].indentexpr =
                        "v:lua.require'nvim-treesitter'.indentexpr()"
                else
                    vim.bo[args.buf].syntax = "ruby"
                end
            end,
        })
    end,
}
