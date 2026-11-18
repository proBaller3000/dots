vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

vim.keymap.set({ "n", "x" }, "x", '"_x', { desc = "Delete without yanking" })
vim.keymap.set({ "n", "x" }, "<leader>d", '"_d', { desc = "Delete without yanking" })
vim.keymap.set({ "n", "x" }, "<leader>p", '"0p', { desc = "Paste yanked text" })

vim.keymap.set("n", "<leader>yf", function()
	Pblr.editor.yank_relative_path_with_line()
end, { desc = "Copy relative path with line" })
vim.keymap.set("n", "<leader>yp", function()
	Pblr.editor.yank_absolute_path_with_line()
end, { desc = "Copy absolute path with line" })
vim.keymap.set("x", "<leader>yc", ":<C-u>lua Pblr.editor.copy_as_codeblock()<CR>", {
	desc = "Copy selection as Markdown code block",
})

vim.keymap.set("n", "dw", 'vb"_d', { desc = "Delete word backwards" })

vim.keymap.set("n", "vag", "ggVG", { desc = "Select all" })
vim.keymap.set("n", "yag", "ggVGy", { desc = "Yank all" })

vim.keymap.set("n", "<leader>-", "<Cmd>split<CR>", { silent = true, desc = "Split window below" })
vim.keymap.set("n", "<leader>|", "<Cmd>vsplit<CR>", { silent = true, desc = "Split window right" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to window above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

vim.keymap.set("n", "<leader>o", "o<Esc>^Da", { silent = true, desc = "Open line below" })
vim.keymap.set("n", "<leader>O", "O<Esc>^Da", { silent = true, desc = "Open line above" })

vim.keymap.set("n", "<BS>", ":", { desc = "Open command line" })

vim.keymap.set("n", "<leader>bo", function()
	Pblr.editor.delete_hidden_buffers()
end, { desc = "Close hidden buffers" })
