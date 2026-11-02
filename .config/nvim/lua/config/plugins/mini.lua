-- lua/custom/plugins/mini.lua
vim.pack.add({
  { src = "https://github.com/echasnovski/mini.nvim", name = "mini"},
})

local statusline = require('mini.statusline')
statusline.setup({ use_icons = true })
