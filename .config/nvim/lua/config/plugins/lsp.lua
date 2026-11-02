return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      vim.lsp.config("ls_lua", {})
      vim.lsp.config("clangd", {})
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', {}),
        callback = function(ev)
          local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

          -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
          if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
          end

          -- Auto-format ("lint") on save.
          -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
          if not client:supports_method('textDocument/willSaveWaitUntil')
              and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
              buffer = ev.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
              end,
            })
          end
        end,
      })
    end,
  },
}
-- if 0 ~= vim.fn.executable('typescript-language-server') then
  -- Enable TypeScript via the Language Server Protocol (LSP)
  -- vim.lsp.enable('tsserver')
  -- vim.cmd [[set completeopt+=menuone,noselect,popup]]
  -- Set the TS config for the LSP
  -- vim.lsp.config('tsserver', {
    -- Make sure this is on your path
    -- cmd = { 'typescript-language-server', '--stdio' },
    -- filetypes = { 'typescript' },
    -- This is a hint to tell nvim to find your project root from a file within the tree
    -- root_dir = vim.fs.root(0, { 'package.json', '.git' }),
    -- on_attach = function(client, bufnr)
      -- vim.lsp.completion.enable(true, client.id, bufnr, {
        -- autotrigger = true,
        -- convert = function(item)
          -- return { abbr = item.label:gsub('%b()', '') }
        -- end,
      -- })
    -- end,
    -- capabilities = capabilities,
    -- optional settings = {...} go here, refer to language server code: https://github.com/typescript-language-server/typescript-language-server/blob/5c483349b7b4b6f79d523f8f4d854cbc5cec7ecd/src/ts-protocol.ts#L379
  })
-- end
