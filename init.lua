-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

-- init.lua

require("keymaps")
require("options")
require("lazy").setup("plugins");
--require("config")
require("config.keymaps")
require("config.options")
require("config.cmake")
require("config.mason")
require("config.mason-lspconfig")
require("config.cmp")
require("config.lsp")
require("config.lsp_rename")
require("config.auto-template")
-- vim.lsp.enable("kotlin-lsp")
-- require("plugins")
--require("plugins.cmake")
--require("plugins.copilot")
--require("plugins.mason")
