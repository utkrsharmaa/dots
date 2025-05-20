-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.root_spec = { "lsp", "cwd" }
vim.o.autochdir = false
vim.opt.shell = "/usr/bin/fish"
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
-- Treesitter folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
