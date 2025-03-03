-- these should be setup explicitly instead of lazy loading 
return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      -- lua
      lspconfig.lua_ls.setup({})
      -- javascript
      lspconfig.ts_ls.setup({})
      -- markdown
      lspconfig.marksman.setup({})

      -- hover
      vim.keymap.set('n', 'H', vim.lsp.buf.hover, {})
      -- Go to Definition
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      -- Code Actions
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
    end
  }
}
