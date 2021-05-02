local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end


return require('packer').startup(function()
  -- Packer can manage itself as an optional plugin
  use {'wbthomason/packer.nvim', opt = true}
  
  --General
  use 'mhinz/vim-startify'
  use 'kyazdani42/nvim-tree.lua'

  -- autocomplete and snippets
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
--  use 'SirVer/ultisnips'
  
  -- Color
  use 'christianchiarulli/nvcode-color-schemes.vim'
  use 'norcalli/nvim-colorizer.lua'
  
  -- Telescope
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-media-files.nvim'

  -- Git
  use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
--  use 'tpope/vim-fugitive'

  -- Treesitter
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'nvim-treesitter/nvim-treesitter-refactor'
  use 'nvim-treesitter/playground'
  use 'p00f/nvim-ts-rainbow'

  -- Icons
  use 'kyazdani42/nvim-web-devicons'
  use 'ryanoasis/vim-devicons'

  -- vimwiki
  use 'vimwiki/vimwiki'

  --gpg
  use 'jamessan/vim-gnupg'

  -- Vim and R
  use 'jalvesaq/Nvim-R'

  -- galaxyline
  use {
  'glepnir/galaxyline.nvim',
    branch = 'main',
    -- some optional icons
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }
  use 'romgrk/barbar.nvim'

end)
