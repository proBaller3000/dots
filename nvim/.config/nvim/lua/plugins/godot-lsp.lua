return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gdscript = {
          cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
          filetypes = { "gd", "gdscript", "gdscript3" },
          root_dir = require("lspconfig.util").root_pattern("project.godot"),
        },
      },
      setup = {
        gdscript = function(_, opts)
          -- this forces setup while still using LazyVim pipeline
          require("lspconfig").gdscript.setup(opts)
          return true
        end,
      },
    },
  },
}
