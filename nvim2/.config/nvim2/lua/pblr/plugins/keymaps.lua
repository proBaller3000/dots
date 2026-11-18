vim.keymap.set("n", "H", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Go to the left tab" })
vim.keymap.set("n", "L", "<Cmd>BufferLineCycleNext<CR>", { desc = "Go to the right tab" })
vim.keymap.set({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash" })

vim.keymap.set("n", "<leader>l", function()
	MiniPick.registry.files()
end, { desc = "Find files" })
vim.keymap.set("n", "<leader>s", function()
	Snacks.picker.grep({ hidden = true, focus = "input" })
end, { desc = "Live grep" })
vim.keymap.set({ "n", "x" }, "<leader>w", function()
	Snacks.picker.grep_word({ hidden = true })
end, { desc = "Grep word" })
vim.keymap.set("n", "<leader>.", function()
	Snacks.picker.resume()
end, { desc = "Resume picker" })
vim.keymap.set("n", "<leader>,", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>e", function()
	Snacks.picker.explorer({ hidden = true, ignored = true })
end, { desc = "Snacks explorer" })
vim.keymap.set("n", "<leader>E", function()
	Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>n", function()
	Snacks.picker.notifications()
end, { desc = "Notification history" })

vim.keymap.set("n", "<leader>gb", function()
	require("gitsigns").blame_line()
end, { desc = "Blame line" })
vim.keymap.set("n", "<leader>gB", function()
	require("gitsigns").blame()
end, { desc = "Blame buffer" })
vim.keymap.set("n", "<leader>gO", function()
	local async = require("gitsigns.async")
	local cache = require("gitsigns.cache").cache

	async.run(function()
		local bufnr = vim.api.nvim_get_current_buf()
		local lnum = vim.api.nvim_win_get_cursor(0)[1]
		local bcache = cache[bufnr]
		if not bcache then
			return
		end

		local info = bcache:get_blame(lnum)
		if not info then
			return
		end

		local sha = info.commit.sha
		if tonumber("0x" .. sha:sub(1, 8)) == 0 then
			vim.notify("Line not committed yet", vim.log.levels.WARN)
			return
		end

		require("gitsigns").show(sha .. ":" .. info.filename, { open = "edit" }, function(err)
			if err then
				vim.notify(err, vim.log.levels.ERROR)
				return
			end
			vim.schedule(function()
				pcall(vim.api.nvim_win_set_cursor, 0, { info.orig_lnum or lnum, 0 })
			end)
		end)
	end)
end, { desc = "Open file from blamed commit" })
vim.keymap.set("n", "<leader>go", function()
	require("mini.diff").toggle_overlay()
end, { desc = "Toggle diff overlay" })
vim.keymap.set("n", "<leader>gs", function()
	require("gitsigns").stage_buffer()
end, { desc = "Stage buffer" })
vim.keymap.set("n", "<leader>gh", function()
	require("gitsigns").stage_hunk()
end, { desc = "Stage or unstage hunk" })
vim.keymap.set("n", "<leader>gH", function()
	Snacks.picker.git_diff()
end, { desc = "Git hunks" })
vim.keymap.set("n", "<leader>gr", function()
	require("gitsigns").reset_hunk()
end, { desc = "Reset hunk" })
vim.keymap.set("n", "]h", function()
	require("gitsigns").nav_hunk("next")
end, { desc = "Next hunk" })
vim.keymap.set("n", "[h", function()
	require("gitsigns").nav_hunk("prev")
end, { desc = "Prev hunk" })

vim.keymap.set("n", "-", function()
	require("oil").open_float(nil, { preview = {} })
end, { desc = "Open file explorer" })

for _, lhs in ipairs({ "grn", "gra", "grr", "gri", "grt", "grx" }) do
	pcall(vim.keymap.del, "n", lhs)
end

vim.keymap.set("n", "gd", function()
	Snacks.picker.lsp_definitions()
end, { desc = "Go to definition" })
vim.keymap.set("n", "gD", function()
	Snacks.picker.lsp_declarations()
end, { desc = "Go to declaration" })
vim.keymap.set("n", "gy", function()
	Snacks.picker.lsp_type_definitions()
end, { desc = "Go to type definition" })
vim.keymap.set("n", "gr", function()
	Snacks.picker.lsp_references()
end, { desc = "List references" })
vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Go to source definition" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show hover docs" })
vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { desc = "Show signature help" })
vim.keymap.set("i", "<C-K>", vim.lsp.buf.signature_help, { desc = "Show signature help" })
vim.keymap.set("n", "]-d", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })
vim.keymap.set("n", "[-d", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Prev diagnostic" })
vim.keymap.set("n", "<C-S-J>", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic with float" })
vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Show code actions" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>cR", Snacks.rename.rename_file, { desc = "Rename file, update imports" })
vim.keymap.set({ "n", "x" }, "<leader>f", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Format now" })
vim.keymap.set("n", "<leader>cl", Snacks.picker.lsp_config, { desc = "Show LSP info" })

local function lsp_icon(name)
	return { cat = "lsp", name = name }
end

local git_icon = { icon = "󰊢", color = "orange" }
local yank_icon = { icon = "󰅇", color = "yellow" }

require("which-key").add({
	{ "x", icon = { icon = "", color = "red" }, mode = "nx" },
	{ "<leader>d", icon = { icon = "", color = "red" }, mode = "nx" },
	{ "<leader>c", group = "Code", icon = lsp_icon("keyword"), mode = "nx" },
	{ "<leader>p", icon = { icon = "󰅇", color = "yellow" }, mode = "nx" },
	{ "dw", icon = { icon = "", color = "red" } },
	{ "vag", icon = { icon = "󰒅", color = "azure" } },
	{ "yag", icon = { icon = "󰅇", color = "yellow" } },
	{ "<leader>o", icon = { icon = "󰐕", color = "green" } },
	{ "<leader>O", icon = { icon = "󰐕", color = "green" } },
	{ "<BS>", icon = { icon = "󰙕", color = "cyan" } },
	{ "<leader>l", icon = { icon = "󰈔", color = "azure" } },
	{ "<leader>s", icon = { icon = "󰱼", color = "green" } },
	{ "<leader>w", icon = { icon = "󰱼", color = "green" }, mode = "nx" },
	{ "<leader>.", icon = { icon = "󰑓", color = "cyan" } },
	{ "<leader>,", icon = { icon = "󰓩", color = "cyan" } },
	{ "<leader>e", icon = { icon = "󰉋", color = "azure" } },
	{ "<leader>E", icon = { icon = "󰅚", color = "red" } },
	{ "<leader>n", icon = { icon = "󰂚", color = "yellow" } },
	{ "<leader>y", group = "Copy helpers", icon = yank_icon },
	{ "<leader>yf", icon = yank_icon },
	{ "<leader>yp", icon = yank_icon },
	{ "<leader>yc", icon = yank_icon, mode = "x" },
	{ "<leader>g", group = "Git", icon = git_icon },
	{ "<leader>gb", icon = git_icon },
	{ "<leader>gB", icon = git_icon },
	{ "<leader>gO", icon = git_icon },
	{ "<leader>go", icon = git_icon },
	{ "<leader>gs", icon = git_icon },
	{ "<leader>gh", icon = git_icon },
	{ "<leader>gH", icon = git_icon },
	{ "<leader>gr", icon = git_icon },
	{ "]h", icon = git_icon },
	{ "[h", icon = git_icon },
	{ "gd", icon = lsp_icon("function") },
	{ "gD", icon = lsp_icon("method") },
	{ "gy", icon = lsp_icon("typeparameter") },
	{ "gr", icon = lsp_icon("reference") },
	{ "gI", icon = lsp_icon("interface") },
	{ "K", icon = lsp_icon("text") },
	{ "gK", icon = lsp_icon("function") },
	{ "<C-K>", icon = lsp_icon("function"), mode = "i" },
	{ "]-d", icon = lsp_icon("event") },
	{ "[-d", icon = lsp_icon("event") },
	{ "<C-S-J>", icon = lsp_icon("event") },
	{ "<leader>ca", icon = lsp_icon("snippet"), mode = "nx" },
	{ "<leader>cr", icon = lsp_icon("key") },
	{ "<leader>cR", icon = lsp_icon("file") },
	{ "<leader>f", icon = lsp_icon("text"), mode = "nx" },
	{ "<leader>cl", icon = lsp_icon("module") },
	{ "-", icon = { icon = "󰉋", color = "azure" } },
})
