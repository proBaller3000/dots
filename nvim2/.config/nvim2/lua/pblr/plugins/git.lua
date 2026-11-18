require("gitsigns").setup({
	signcolumn = false,
})

require("mini.diff").setup({
	view = {
		style = "number",
	},
	mappings = {
		apply = "",
		reset = "",
		textobject = "",
		goto_first = "",
		goto_prev = "",
		goto_next = "",
		goto_last = "",
	},
})

vim.api.nvim_set_hl(0, "MiniDiffSignAdd", { link = "DiagnosticOk" })
vim.api.nvim_set_hl(0, "MiniDiffSignChange", { link = "DiagnosticInfo" })
vim.api.nvim_set_hl(0, "MiniDiffSignDelete", { link = "DiagnosticError" })
