vim.pack.add({
	"https://github.com/RRethy/base16-nvim",
	"https://github.com/rachartier/tiny-cmdline.nvim",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/nvim-mini/mini.pairs",
	"https://github.com/nvim-mini/mini.diff",
	"https://github.com/akinsho/bufferline.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/folke/snacks.nvim",
	"https://github.com/folke/flash.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/nvim-mini/mini.pick",
	"https://github.com/stevearc/oil.nvim",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/brenoprata10/nvim-highlight-colors",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
})

require("pblr.plugins.ui")
require("pblr.plugins.picker")
require("pblr.plugins.oil")
require("pblr.plugins.treesitter")
require("pblr.plugins.highlights")
require("pblr.plugins.completion")
require("pblr.plugins.pairs")
require("pblr.plugins.flash")
require("pblr.plugins.git")
require("pblr.plugins.lsp")
require("pblr.plugins.keymaps")
