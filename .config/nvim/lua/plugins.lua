local status, packer = pcall(require, 'packer')
if (not status) then
  print("uh oh, packer not installed, stinky")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'svrana/neosolarized.nvim', -- color scheme
    requires = { 'tjdevries/colorbuddy.nvim' }
  }
  use 'L3MON4D3/LuaSnip'            -- snippets
  use 'saadparwaiz1/cmp_luasnip'    -- integrate lua snippets with cmp
  use 'nvim-tree/nvim-web-devicons' -- file icons
  use 'nvimdev/lspsaga.nvim'
  use 'nvim-lualine/lualine.nvim'   -- statusline
  use 'onsails/lspkind-nvim'        -- pictograms
  use 'hrsh7th/cmp-buffer'          -- nvim-cmp source for buffer words
  use 'hrsh7th/cmp-nvim-lsp'        -- nvim-cmp source for nvim's built in LSP
  use 'hrsh7th/nvim-cmp'            -- autocomplete
  use 'neovim/nvim-lspconfig'       -- LSP
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'

  use 'nvim-lua/plenary.nvim' -- common utilities
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'

  use 'akinsho/nvim-bufferline.lua' -- file tabs
  use 'norcalli/nvim-colorizer.lua' -- color code highlightings
end)
