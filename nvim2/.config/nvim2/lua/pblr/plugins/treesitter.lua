local TS = require("nvim-treesitter")

TS.install({
	"bash",
	"c",
	"cmake",
	"cpp",
	"css",
	"diff",
	"fish",
	"gitignore",
	"go",
	"html",
	"http",
	"json",
	"lua",
	"luadoc",
	"luap",
	"markdown",
	"markdown_inline",
	"php",
	"printf",
	"python",
	"query",
	"regex",
	"rust",
	"ron",
	"sql",
	"svelte",
	"toml",
	"typescript",
	"vim",
	"vimdoc",
	"xml",
	"yaml",
})

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("PblrTreesitter", { clear = true }),
	callback = function(ev)
		local lang = vim.treesitter.language.get_lang(ev.match)
		if not lang or not vim.treesitter.language.add(lang) then
			return
		end

		vim.treesitter.start(ev.buf)
		vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		if ev.data.spec.name ~= "nvim-treesitter" then
			return
		end
		if ev.data.kind ~= "install" and ev.data.kind ~= "update" then
			return
		end

		vim.cmd.packadd("nvim-treesitter")
		vim.cmd("TSUpdate")
	end,
})
