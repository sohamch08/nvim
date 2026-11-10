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
		[".*/%.?cmus/rc"] = { "cmus", { priority = 10 } },
		[".*/%.?cmus/.*%.conf"] = { "cmus", { priority = 10 } },
		[".*/%.?cmus/.*%.theme"] = { "cmus", { priority = 10 } },
	},
})
