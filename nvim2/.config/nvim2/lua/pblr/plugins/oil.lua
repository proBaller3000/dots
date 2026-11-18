require("oil").setup({
	columns = { "icon" },
	view_options = { show_hidden = true },
	keymaps = {
		["-"] = { "actions.parent", mode = "n" },
		["q"] = { "actions.close", mode = "n" },
	},
	float = {
		max_width = 0.9,
		max_height = 0.9,
		border = "rounded",
	},
})
