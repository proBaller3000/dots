local kind_icons = {}
for _, kind in ipairs(vim.lsp.protocol.CompletionItemKind) do
	kind_icons[kind] = MiniIcons.get("lsp", kind)
end

require("blink.cmp").setup({
	keymap = { preset = "enter" },
	completion = {
		accept = {
			auto_brackets = { enabled = true },
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
		ghost_text = { enabled = true },
		menu = {
			draw = { treesitter = { "lsp" } },
		},
	},
	cmdline = {
		completion = {
			list = { selection = { preselect = false } },
			menu = {
				auto_show = function()
					return vim.fn.getcmdtype() == ":"
				end,
			},
		},
	},
	appearance = {
		kind_icons = kind_icons,
	},
})
