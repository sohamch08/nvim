return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local theme = vim.deepcopy(require("lualine.themes.nord"))
		theme.visual.a.bg = "#EBC29B"
		theme.command = { a = vim.deepcopy(theme.normal.a) }
		theme.command.a.bg = "#A3BE8C"

		local mode = {
			"mode",
			fmt = function(str)
				return " " .. str
				-- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
			end,
		}

		local filename = {
			"filename",
			file_status = true, -- displays file status (readonly status, modified status)
			path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
		}

		local recording = {
			function()
				local register = vim.fn.reg_recording()
				return register ~= "" and ("REC @" .. register) or ""
			end,
			color = { fg = "#F7768E", gui = "bold" },
		}

		vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
			group = vim.api.nvim_create_augroup("LualineRecording", { clear = true }),
			callback = function()
				-- RecordingLeave fires before reg_recording() has been cleared.
				vim.schedule(function()
					require("lualine").refresh({ place = { "statusline" } })
				end)
			end,
		})

		local hide_in_width = function()
			return vim.fn.winwidth(0) > 100
		end

		local diagnostics = {
			"diagnostics",
			sources = { "nvim_diagnostic" },
			sections = { "error", "warn" },
			symbols = { error = " ", warn = " ", info = " ", hint = " " },
			colored = true,
			update_in_insert = false,
			always_visible = false,
			cond = hide_in_width,
		}

		local diff = {
			"diff",
			colored = true,
			symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
			cond = hide_in_width,
		}

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = theme,
				-- Standard Powerline glyphs supported by MapleMono Nerd Font.
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				disabled_filetypes = { "alpha", "neo-tree" },
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { "branch" },
				lualine_c = { filename, recording },
				lualine_x = {
					{ "%S", type = "stl" },
					diagnostics,
					diff,
					{ "encoding", cond = hide_in_width },
					{ "filetype" },
				},
				lualine_y = { "location" },
				lualine_z = { "progress" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { { "location", padding = 0 } },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { "fugitive" },
		})
	end,
}
