require("mason").setup()

require("mason-tool-installer").setup({
	ensure_installed = {
		"lua-language-server",
		"rust-analyzer",
		"clangd",
		"ruff",
		"stylua",
		"shfmt",
	},
	auto_update = false,
	run_on_start = true,
})

local capabilities = {
	workspace = {
		fileOperations = {
			didRename = true,
			willRename = true,
		},
	},
}

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(capabilities),
})

vim.lsp.config("pyright", {
	cmd = { "uvx", "--from", "pyright", "pyright-langserver", "--stdio" },
})

vim.lsp.config("clangd", {
	cmd = { "clangd", "--clang-tidy" },
})

vim.lsp.enable({ "lua_ls", "rust_analyzer", "clangd", "ruff", "pyright" })

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.py",
	callback = function()
		vim.lsp.buf.format({
			async = false,
			filter = function(client)
				return client.name == "ruff"
			end,
		})
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.c", "*.h", "*.cc", "*.cpp", "*.cxx", "*.hpp", "*.hxx" },
	callback = function()
		vim.lsp.buf.format({
			async = false,
			filter = function(client)
				return client.name == "clangd"
			end,
		})
	end,
})
