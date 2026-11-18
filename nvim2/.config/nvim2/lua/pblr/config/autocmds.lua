local group = vim.api.nvim_create_augroup("Pblr", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = group,
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("WinEnter", {
	group = group,
	command = "setlocal cursorline",
})

vim.api.nvim_create_autocmd("WinLeave", {
	group = group,
	command = "setlocal nocursorline",
})
