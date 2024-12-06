local opt = vim.opt
local vim = vim
local Plug = vim.fn['plug#']

opt.background = 'dark'
opt.cursorline = true
opt.number = true
opt.relativenumber = false
opt.termguicolors = true
vim.lsp.set_log_level("debug")

--vim.cmd[[colorscheme tokyonight]]
vim.call('plug#begin')

Plug('wbthomason/packer.nvim') -- Plugin manager
Plug('neovim/nvim-lspconfig') -- LSP client
Plug('hrsh7th/cmp-nvim-lsp')


-- Plugin di completamento
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')

-- Snippet engine
-- Plug('L3MON4D3/LuaSnip')
Plug('saadparwaiz1/cmp_luasnip')

Plug("folke/tokyonight.nvim")
Plug('m4xshen/autoclose.nvim')

--Plug('neoclide/coc.nvim', { ['branch'] = 'release' })
Plug('preservim/nerdtree')
Plug('davidgranstrom/scnvim')
Plug('L3MON4D3/LuaSnip', { ['tag'] = 'v2.*', ['do'] = 'make install_jsregexp' })
--Plug("saadparwaiz1/cmp_luasnip")
--Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('rafamadriz/friendly-snippets')
--Plug('neovim/nvim-lspconfig')



vim.call('plug#end')

dofile(os.getenv('HOME') .. '/.local/share/nvim/plugged/tokyonight.nvim/lua/tokyonight/init.lua')
vim.cmd[[colorscheme tokyonight]]

vim.o.completeopt = "menu,menuone,noselect" -- Configura il completamento
--vim.o.termguicolors = true                  -- Abilita i colori nella terminale
--vim.o.number = true                         -- Mostra i numeri di riga

require('snip')
require("luasnip.loaders.from_snipmate").lazy_load()
require("autoclose").setup()
require('sc')

vim.cmd[[autocmd vimenter * NERDTree]]
vim.cmd[[filetype on]]

vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]


--
--CONFIGURA SERVER LINGUISTICO SUPERCOLLIDER
--
-- Configura il tuo server LSP
local lspconfig = require('lspconfig')

-- Integrazione delle capacità di completamento con LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local cmd = { "/home/neum/anaconda3/bin/python", "/home/neum/.config/nvim/oldstyle.py" }
local configs = require 'lspconfig.configs'

-- Check if the config is already defined (useful when reloading this file)
if not configs.supercollider_lsp then
    configs.supercollider_lsp = {
    default_config = {
        cmd = cmd,
        filetypes = {'supercollider'},
        root_dir = function(fname)
            return vim.loop.cwd()
          end,
        settings = {},
    },
    }
end

lspconfig.supercollider_lsp.setup({
    on_attach = function(client, bufnr)
        print("SuperCollider LSP avviato!") -- Messaggio di connessione
      end,
      --capabilities = vim.lsp.protocol.make_client_capabilities()   
      capabilities = capabilities
})


-- Configura il completamento con nvim-cmp
local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- Usa LuaSnip per gli snippet
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Conferma con Enter
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, -- Fonte LSP
    { name = 'luasnip' },  -- Fonte Snippet
  }, {
    { name = 'buffer' },   -- Completamento dai buffer
    { name = 'path' },     -- Completamento dei percorsi
  }),
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


