vim.o.hidden = true
vim.o.relativenumber = true
vim.o.encoding = "utf-8"
vim.o.expandtab = true
vim.o.shiftwidth = 3
vim.o.tabstop = 3
vim.o.backup = false
vim.o.writebackup = false
vim.o.ruler = true
vim.o.showcmd = true
vim.o.incsearch = true
vim.o.laststatus = 2
vim.o.hlsearch = true
vim.o.cursorline = true

vim.cmd.colorscheme("catppuccin")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Enable TypeScript via the Language Server Protocol (LSP)
vim.lsp.enable('tsserver')
vim.cmd[[set completeopt+=menuone,noselect,popup]]
-- Set the TS config for the LSP
vim.lsp.config('tsserver', {
  -- Make sure this is on your path
  cmd = {'typescript-language-server', '--stdio'},
  filetypes = { 'typescript' },
  -- This is a hint to tell nvim to find your project root from a file within the tree
  root_dir = vim.fs.root(0, {'package.json', '.git'}),
  on_attach = function(client, bufnr)
    vim.lsp.completion.enable(true, client.id, bufnr, {
      autotrigger = true,
      convert = function(item)
        return { abbr = item.label:gsub('%b()', '') }
      end,
    })
  end,
  capabilities = capabilities,
  -- optional settings = {...} go here, refer to language server code: https://github.com/typescript-language-server/typescript-language-server/blob/5c483349b7b4b6f79d523f8f4d854cbc5cec7ecd/src/ts-protocol.ts#L379
})

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
