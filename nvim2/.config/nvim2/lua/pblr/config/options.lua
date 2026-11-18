vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 10
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.cmdheight = 0
opt.laststatus = 3
opt.winborder = "rounded"
opt.pumheight = 10
opt.showmatch = true
opt.matchtime = 2
opt.title = true
opt.fillchars:append({ diff = "╱" })
opt.splitbelow = true
opt.splitright = true
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.iskeyword:append("-")
opt.ignorecase = true
opt.smartcase = true
opt.path:append("**")
opt.wildmode = "longest:full,full"
opt.wildignore:append({
	"*/node_modules/*",
	"*.o",
	"*.obj",
	"*.pyc",
	"*.class",
	"*.jar",
})
opt.swapfile = false
opt.writebackup = false
local undodir = vim.fn.expand("~/.cache/nvim/undodir")
vim.fn.mkdir(undodir, "p")
opt.undodir = undodir
opt.undofile = true
opt.updatetime = 300
opt.timeoutlen = 500
opt.ttimeoutlen = 0
opt.termguicolors = true
opt.clipboard = "unnamedplus"

require("vim._core.ui2").enable({
	enable = true,
	msg = {
		targets = {
			[""] = "msg",
			empty = "cmd",
			bufwrite = "msg",
			confirm = "cmd",
			emsg = "pager",
			echo = "msg",
			echomsg = "msg",
			echoerr = "pager",
			completion = "cmd",
			list_cmd = "pager",
			lua_error = "pager",
			lua_print = "msg",
			progress = "pager",
			rpc_error = "pager",
			quickfix = "msg",
			search_cmd = "cmd",
			search_count = "cmd",
			shell_cmd = "pager",
			shell_err = "pager",
			shell_out = "pager",
			shell_ret = "msg",
			undo = "msg",
			verbose = "pager",
			wildlist = "cmd",
			wmsg = "msg",
			typed_cmd = "cmd",
		},
		cmd = { height = 0.5 },
		dialog = { height = 0.5 },
		msg = { height = 0.3, timeout = 5000 },
		pager = { height = 0.5 },
	},
})
