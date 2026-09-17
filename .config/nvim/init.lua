require("config.lazy")

vim.opt.hidden = true
vim.opt.relativenumber = true
vim.opt.encoding = "utf-8"
vim.opt.expandtab = true
vim.opt.shiftwidth = 3
vim.opt.tabstop = 3
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.hlsearch = true
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

if 0 ~= vim.fn.executable('typescript-language-server') then
  -- Enable TypeScript via the Language Server Protocol (LSP)
  vim.lsp.enable('tsserver')
  vim.cmd [[set completeopt+=menuone,noselect,popup]]
  -- Set the TS config for the LSP
  vim.lsp.config('tsserver', {
    -- Make sure this is on your path
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'typescript' },
    -- This is a hint to tell nvim to find your project root from a file within the tree
    root_dir = vim.fs.root(0, { 'package.json', '.git' }),
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
end
vim.lsp.enable('lua_ls')
vim.lsp.enable('clangd')

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})

-- Highlight when yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
