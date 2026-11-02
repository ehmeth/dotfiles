vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
})

----- Treesitter -----
-- modified version of code from this config
--https://github.com/fredrikaverpil/dotfiles/blob/main/nvim-fredrik/lua/fredrik/plugins/core/treesitter.lua
local ts_ensure_installed = {
  "bash",
  "c",
  "css",
  "diff",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "toml",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

-- Install parsers and register them for filetypes
require("nvim-treesitter").install(ts_ensure_installed)

for _, parser in ipairs(ts_ensure_installed) do
  vim.treesitter.language.register(parser, parser)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = parser,
    callback = function(event)
      vim.treesitter.start(event.buf, parser)
    end,
  })
end

require('nvim-treesitter').update()
