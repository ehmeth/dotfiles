-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading plugins
-- This is also a good place to setup other settings (vim.opt)
--
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.pack.add { 
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } ,
  "https://github.com/nvim-tree/nvim-web-devicons",
}

vim.cmd[[colorscheme catppuccin-macchiato]]

-- FIXME(kleindan) LOAD OTHER PLUGINS!
-- import config plugins!
require("config.plugins.telescope")
require("config.plugins.mini")
require("config.plugins.treesitter")

-- local config_path = vim.fn.stdpath("config")
-- for _, file in ipairs(vim.fn.readdir(config_path .. "/lua", [[v:val =~ '\.lua$']])) do
--   require(file:gsub("%.lua$", ""))
-- end
