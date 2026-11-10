return {
    -- HACK: docs @ https://github.com/folke/snacks.nvim/blob/main/docs
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        -- NOTE: Options
        opts = {
            explorer = { enabled = true },
            scroll = { enabled = true },
            indent = {
               priority = 1,
               enabled = true, -- enable indent guides
               char = "│",
               only_scope = false, -- only show indent guides of the scope
               only_current = false, -- only show indent guides in the current window
               hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
               -- can be a list of hl groups to cycle through
               -- hl = {
               --     "SnacksIndent1",
               --     "SnacksIndent2",
               --     "SnacksIndent3",
               --     "SnacksIndent4",
               --     "SnacksIndent5",
               --     "SnacksIndent6",
               --     "SnacksIndent7",
               --     "SnacksIndent8",
               -- },
            },
            -- animate scopes. Enabled by default for Neovim >= 0.10
            -- Works on older versions but has to trigger redraws during animation.
            --- * out: animate outwards from the cursor
            --- * up: animate upwards from the cursor
            --- * down: animate downwards from the cursor
            --- * up_down: animate up or down based on the cursor position
            ---@type snacks.indent.animate
            animate = {
              enabled = vim.fn.has("nvim-0.10") == 1,
              style = "out",
              easing = "linear",
              duration = {
                step = 20, -- ms per step
                total = 500, -- maximum duration
              },
            },
            ---@type snacks.indent.Scope.Config
            scope = {
              enabled = true, -- enable highlighting the current scope
              priority = 200,
              char = "│",
              underline = false, -- underline the start of the scope
              only_current = false, -- only show scope in the current window
              hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
            },
            chunk = {
              -- when enabled, scopes will be rendered as chunks, except for the
              -- top-level scope which will be rendered as a scope.
              enabled = false,
              -- only show chunk scopes in the current window
              only_current = false,
              priority = 200,
              hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
              char = {
                corner_top = "┌",
                corner_bottom = "└",
                -- corner_top = "╭",
                -- corner_bottom = "╰",
                horizontal = "─",
                vertical = "│",
                arrow = ">",
              },
            },
            -- filter for buffers to enable indent guides
            -- @param buf number
            -- @param win number
            -- filter = function(buf, win)
            --   return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
            -- end,
            styles = {
                input = {
                    keys = {
                        n_esc = { "<C-c>", { "cmp_close", "cancel" }, mode = "n", expr = true },
                        i_esc = { "<C-c>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
                    },
                }
            },
            -- Snacks Modules
            input = {
                enabled = true,
            },
            quickfile = {
                enabled = true,
                exclude = { "latex" },
            },
            -- HACK: read picker docs @ https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
            picker = {
                enabled = true,
                matchers = {
                    frecency = true,
                    cwd_bonus = false,
                },
                exclude = {
                    ".git",
                    "node_modules",
                    "dist",
                    "build",
                },
                formatters = {
                    file = {
                        filename_first = true,
                        filename_only = false,
                        icon_width = 2,
                    },
                },
                layout = {
                    -- presets options : "default" , "ivy" , "ivy-split" , "telescope" , "vscode", "select" , "sidebar"
                    -- override picker layout in keymaps function as a param below
                    preset = "telescope", -- defaults to this layout unless overidden
                    cycle = false,
                },
                layouts = {
                    select = {
                            preview = false,
                            layout = {
                                backdrop = false,
                                width = 0.6,
                                min_width = 80,
                                height = 0.4,
                                min_height = 10,
                                box = "vertical",
                                border = "rounded",
                                title = "{title}",
                                title_pos = "center",
                                { win = "input", height = 1, border = "bottom" },
                                { win = "list", border = "none" },
                                { win = "preview", title = "{preview}", width = 0.6, height = 0.4, border = "top" },
                        }
                    },
                    telescope = {
                        reverse = true, -- set to false for search bar to be on top 
                        layout = {
                            box = "horizontal",
                            backdrop = false,
                            width = 0.8,
                            height = 0.9,
                            border = "none",
                            {
                                box = "vertical",
                                { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
                                { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
                            },
                            {
                                win = "preview",
                                title = "{preview:Preview}",
                                width = 0.50,
                                border = "rounded",
                                title_pos = "center",
                            },
                        },
                    },
                    ivy = {
                        layout = {
                            box = "vertical",
                            backdrop = false,
                            width = 0,
                            height = 0.4,
                            position = "bottom",
                            border = "top",
                            title = " {title} {live} {flags}",
                            title_pos = "left",
                            { win = "input", height = 1, border = "bottom" },
                            {
                                box = "horizontal",
                                { win = "list", border = "none" },
                                { win = "preview", title = "{preview}", width = 0.5, border = "left" },
                            },
                        },
                    },
                }
            },
            image = {
                enabled = vim.env.TERM == "xterm-kitty"
                    or vim.env.TERM_PROGRAM == "WezTerm"
                    or vim.env.TERM_PROGRAM == "ghostty",
                doc = {
                    float = false, -- show image on cursor hover
                    inline = false, -- show image inline
                    max_width = 50,
                    max_height = 30,
                    wo = {
                        wrap = false,
                    },
                },
                convert = {
                    notify = true,
                    command = "magick"
                },
                img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments","Archives/All-Vault-Images/", "~/Library", "~/Downloads" },
            },
            -- dashboard = {
            --     enabled = true,
            --     sections = {
            --         { section = "header" },
            --         { section = "keys", gap = 1, padding = 1 },
            --         { section = "startup" },
            --         {
            --             section = "terminal",
            --             cmd = "ascii-image-converter ~/Desktop/Others/profiles.JPG -C -c",
            --             random = 15,
            --             pane = 2,
            --             indent = 15,
            --             height = 20,
            --         },
            --     },
            -- },
        },
        -- NOTE: Keymaps
        keys = {
            { "<leader>lg", function() require("snacks").lazygit() end, desc = "Lazygit" },
            { "<leader>gl", function() require("snacks").lazygit.log() end, desc = "Lazygit Logs" },
            { "<leader>e",  function() require("snacks").explorer() end, desc = "Open Snacks Explorer"},
            { "<leader>rN", function() require("snacks").rename.rename_file() end, desc = "Fast Rename Current File" },
            { "<leader>dB", function() require("snacks").bufdelete() end, desc = "Delete or Close Buffer  (Confirm)" },

            -- Snacks Picker
            { "<leader>pf", function() require("snacks").picker.files() end, desc = "Find Files (Snacks Picker)" },
            { "<leader>pc", function() require("snacks").picker.files({ cwd = vim.fn.stdpath("config") .. "/lua" }) end, desc = "Find Config File" },
            { "<leader>ps", function() require("snacks").picker.grep() end, desc = "Grep word" },
            { "<leader>pws", function() require("snacks").picker.grep_word() end, desc = "Search Visual selection or Word", mode = { "n", "x" } },
            { "<leader>pk", function() require("snacks").picker.keymaps({ layout = "ivy" }) end, desc = "Search Keymaps (Snacks Picker)" },

            -- Git Stuff
            { "<leader>gbr", function() require("snacks").picker.git_branches({ layout = "select" }) end, desc = "Pick and Switch Git Branches" },

            -- Other Utils
            { "<leader>th" , function() require("snacks").picker.colorschemes({ layout = "ivy" }) end, desc = "Pick Color Schemes"},
            { "<leader>vh", function() require("snacks").picker.help() end, desc = "Help Pages" },
        },
        config = function(_, opts)
            require("snacks").setup(opts)
            -- Rose Pine Moon colors
            vim.api.nvim_set_hl(0, "SnacksIndent",       { fg = "#403d52" }) -- subtle
            vim.api.nvim_set_hl(0, "SnacksIndentScope",  { fg = "#eb6f92" }) -- strong rose highlight
            vim.api.nvim_set_hl(0, "SnacksIndentChunk",  { fg = "#c4a7e7" }) -- lavender accent
        end,
    },
    -- NOTE: todo comments w/ snacks
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPre", "BufNewFile" },
        optional = true,
        keys = {
            { "<leader>pt", function() require("snacks").picker.todo_comments() end, desc = "All" },
            { "<leader>pT", function() require("snacks").picker.todo_comments({ keywords = { "TODO","FORGETNOT","FIXME" } }) end, desc = "mains" },
        },
    }
}
