return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>,",
        function()
          require("snacks").picker.buffers({ current = false })
          vim.schedule(function()
            vim.cmd.stopinsert()
          end)
        end,
        desc = "Buffers",
      },
    },
    opts = {
      picker = {
        sources = {
          -- file finder
          files = {
            hidden = true,  -- show dotfiles
            ignored = true, -- also show gitignored files
          },

          -- live grep / text search
          grep = {
            hidden = true,
            ignored = true,
          },

          -- file explorer
          explorer = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
  },
}
