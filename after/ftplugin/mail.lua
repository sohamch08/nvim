vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
vim.opt_local.textwidth = 72
vim.opt_local.wrap = true
-- Use Vim's mail-aware formatting for gq instead of the global Conform hook.
vim.opt_local.formatexpr = ""

vim.b.undo_ftplugin = (vim.b.undo_ftplugin or "")
	.. " | setlocal spell< spelllang< textwidth< wrap< formatexpr<"
