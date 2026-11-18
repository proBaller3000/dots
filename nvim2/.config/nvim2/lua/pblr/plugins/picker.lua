local MiniPick = require("mini.pick")

MiniPick.setup({
	source = {
		show = function(buf, items, query)
			MiniPick.default_show(buf, items, query, { show_icons = true })
		end,
	},
})

MiniPick.registry.files = function()
	return MiniPick.builtin.cli({
		command = { "rg", "--files", "--hidden", "--glob=!.git", "--color=never" },
	}, { source = { name = "Files" } })
end
