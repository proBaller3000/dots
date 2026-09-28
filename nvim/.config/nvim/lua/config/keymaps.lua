-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-=>", function()
  vim.o.guifont = vim.o.guifont .. ":h+1"
end)
vim.keymap.set("n", "<C-->", function()
  vim.o.guifont = vim.o.guifont .. ":h-1"
end)

vim.keymap.set("n", "<BS>", ":", { desc = "command" })

vim.keymap.set("n", "<leader>p", function()
  local term = Snacks.terminal.get(nil, { cwd = LazyVim.root(), auto_close = true })
  if not term then
    return Snacks.notify.error("Failed to open terminal")
  end
  local buf = term.buf
  if not term:valid() then
    term:show()
  end
  vim.schedule(function()
    local channel = vim.bo[buf].channel
    if vim.bo[buf].buftype == "terminal" and channel and channel > 0 then
      vim.api.nvim_chan_send(channel, "play; exit 0\r")
    end
  end)
end, { desc = "Godot Play" })
