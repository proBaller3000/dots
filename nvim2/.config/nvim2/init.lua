vim.loader.enable()

_G.Pblr = require("pblr.utils")

require("pblr.config.options")
require("pblr.config.keymaps")
require("pblr.config.autocmds")
require("pblr.config.commands")
require("pblr.config.workarounds")

require("pblr.plugins")
