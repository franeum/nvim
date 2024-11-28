local opt = vim.opt
local vim = vim
local Plug = vim.fn['plug#']

opt.background = 'dark'
opt.cursorline = true
opt.number = true
opt.relativenumber = false
opt.termguicolors = true

--vim.cmd[[colorscheme tokyonight]]
vim.call('plug#begin')

Plug('ellisonleao/gruvbox.nvim')
Plug("folke/tokyonight.nvim")
Plug('m4xshen/autoclose.nvim')
Plug('neoclide/coc.nvim', { ['branch'] = 'release' })
Plug('preservim/nerdtree')
Plug('davidgranstrom/scnvim')
Plug('L3MON4D3/LuaSnip', { ['tag'] = 'v2.*', ['do'] = 'make install_jsregexp' })
Plug("saadparwaiz1/cmp_luasnip")
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')

vim.call('plug#end')

dofile('/home/neum/.local/share/nvim/plugged/tokyonight.nvim/lua/tokyonight/init.lua')
vim.cmd[[colorscheme tokyonight]]

require('snip')
require("luasnip.loaders.from_snipmate").lazy_load()
require("autoclose").setup()
require('sc')

-- vim.cmd[[NERDTree]]
vim.cmd[[autocmd vimenter * NERDTree]]
vim.cmd[[filetype on]]

vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]
