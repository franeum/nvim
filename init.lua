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
Plug('rafamadriz/friendly-snippets')
Plug('neovim/nvim-lspconfig')

vim.call('plug#end')

dofile(os.getenv('HOME') .. '/.local/share/nvim/plugged/tokyonight.nvim/lua/tokyonight/init.lua')
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


local cmp = require'cmp'
local luasnip = require'luasnip'

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  },
  formatting = {
    fields = { 'abbr', 'kind', 'menu' },
    format = function(entry, vim_item)
      vim_item.kind = string.format('%s', vim_item.kind)
      vim_item.menu = ({
        luasnip = '[Snip]',
        nvim_lsp = '[LSP]',
        buffer = '[Buffer]',
        path = '[Path]',
      })[entry.source.name]
      return vim_item
    end,
  },
})

-- Abilita il completamento per gli snippet
--[[
require'cmp'.setup {
  sources = {
    { name = 'luasnip' },
  },
}
]]--

local lspconfig = require('lspconfig')

lspconfig.oldstyle = {
    cmd = {"python", "/home/franeum/Documenti/supercollider_lsp/oldstyle.py"}, -- Percorso del server
    filetypes = {"supercollider"}, 
    root_dir = function(fname)
        return vim.fn.getcwd() -- Usa la directory corrente come root
    end,
    on_attach = function(client, bufnr)
    -- Funzioni da eseguire quando il client si connette
      require('lsp').on_attach(client, bufnr)
    end,
    settings = {}
}

