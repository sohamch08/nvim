require("core.options")
require("core.keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("plugins.autopairs"),
	require("plugins.oil"),
	require("plugins.snacks"),
	require("plugins.todo-comments"),
	require("plugins.mini"),
	require("plugins.flash"),
	require("plugins.list-formatter"),
	require("plugins.comments"),
	require("plugins.ide"),
	require("plugins.telescope"),
	require("plugins.gitsigns"),
	require("plugins.misc"),
	require("plugins.ui"),
}, {
	rocks = { enabled = false },
})
vim.cmd("colorscheme catppuccin")
