require("snacks").setup({
	indent = { enabled = true },
	notifier = { enabled = true },
	picker = {
		enabled = true,
		focus = "list",
	},
	statuscolumn = { enabled = true },
	scroll = { enabled = false },
})

require("which-key").setup({
	win = {
		width = 50,
		height = { max = 0.5 },
		col = math.huge,
		border = "rounded",
	},
	spec = {
		{ "<leader>b", group = "Buffers", icon = { icon = "󰈔", color = "cyan" } },
	},
})

require("matugen").setup()

require("tiny-cmdline").setup({
	position = {
		y = "20%",
	},
})

require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

vim.diagnostic.config({
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	virtual_text = {
		prefix = "●",
		source = "if_many",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = Pblr.icons.diagnostics.Error,
			[vim.diagnostic.severity.WARN] = Pblr.icons.diagnostics.Warn,
			[vim.diagnostic.severity.HINT] = Pblr.icons.diagnostics.Hint,
			[vim.diagnostic.severity.INFO] = Pblr.icons.diagnostics.Info,
		},
	},
})

local colors = require("base16-colorscheme").colors

require("bufferline").setup({
	options = {
		mode = "buffers",
		always_show_bufferline = false,
		name_formatter = function(buf)
			if vim.bo[buf.bufnr].buftype == "terminal" then
				return "[Terminal]"
			end
			return buf.name
		end,
		get_element_icon = function(opts)
			if opts.type == "terminal" or opts.path == "" or opts.path == "[No Name]" then
				return ""
			end
		end,
	},
	highlights = {
		-- fill = { bg = "NONE" },
		-- background = { bg = "NONE" },
		-- buffer_selected = { fg = colors.base05, bg = "NONE" },
		-- tab_close = { bg = "NONE" },
		-- close_button = { fg = colors.base04, bg = "NONE" },
		-- close_button_selected = { fg = colors.base05, bg = "NONE" },
		-- separator = { bg = "NONE" },
		-- separator_selected = { bg = "NONE" },
	},
})

local function project_root()
	local root = vim.fs.root(0, { ".git", "Cargo.toml", "pyproject.toml" })
	if not root or root == vim.fn.getcwd() then
		return ""
	end
	return vim.fs.basename(root)
end

local function macro()
	local reg = vim.fn.reg_recording()
	if reg == "" then
		reg = vim.fn.reg_executing()
	end
	return reg == "" and "" or "@" .. reg
end

require("lualine").setup({
	options = {
		theme = "auto",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { project_root, { "filetype", icon_only = true }, { "filename", path = 1 } },
		lualine_x = { macro, "diagnostics", "diff" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
	callback = function()
		require("lualine").refresh()
	end,
})

-- local transparent = function()
-- 	for _, name in ipairs({
-- 		"Normal",
-- 		"NormalNC",
-- 		"LineNr",
-- 		"CursorLineNr",
-- 		"SignColumn",
-- 		"FoldColumn",
-- 		"EndOfBuffer",
-- 		"WinSeparator",
-- 		"VertSplit",
-- 	}) do
-- 		local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
-- 		if ok then
-- 			hl.bg = nil
-- 			vim.api.nvim_set_hl(0, name, hl)
-- 		end
-- 	end
-- end
--
-- transparent()
--
-- vim.api.nvim_create_autocmd("ColorScheme", { callback = transparent })
-- vim.api.nvim_create_autocmd("Signal", {
-- 	pattern = "SIGUSR1",
-- 	callback = function()
-- 		vim.defer_fn(transparent, 50)
-- 	end,
-- })
