vim.filetype.add({
	filename = {
		[".gitaliases"] = "gitconfig",
		["msmtprc"] = "msmtp",
		[".msmtprc"] = "msmtp",
		[".notmuch-config"] = "dosini",
		["notmuch-config"] = "dosini",
	},
	pattern = {
		[".*muttrc"] = "muttrc",
	},
})
