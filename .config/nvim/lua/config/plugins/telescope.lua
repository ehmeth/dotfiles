vim.api.nvim_create_autocmd("PackChanged", {
  callback = function (ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    local path = ev.data.path

    if (name == 'telescope-fzf-native' and (kind == 'install' or kind == 'update')) then
      local obj = vim.system({ 'make' }, { cwd = path })
      local result = obj:wait()
      if (result.code == 0) then
        vim.notify("telescope-fzf-native built correctly", vim.log.levels.INFO)
      else
        vim.notify("ERROR: there was a problem building telescope-fzf-native: " .. result, vim.log.levels.ERROR)
      end
    end
  end,
})

vim.pack.add({
  { src = 'https://github.com/nvim-lua/plenary.nvim', },
  { src = 'https://github.com/nvim-telescope/telescope.nvim', name = 'telescope' },
  { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim', name = 'telescope-fzf-native'},
})


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(require("telescope.config").values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

require("telescope").setup({
  defaults = {
    -- `hidden = true` is not supported in text grep commands.
    vimgrep_arguments = vimgrep_arguments,
  },
  pickers = {
    find_files = {
      -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
      find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
    },
  },
  extensions = {
    fzf = {},
  },
})
require("telescope").load_extension("fzf")
require("config.telescope.multigrep").setup()
