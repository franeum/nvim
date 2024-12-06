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
require'cmp'.setup {
  sources = {
    { name = 'luasnip' },
  },
}

local lspconfig = require("lspconfig")

-- Define the SuperCollider LSP
lspconfig.supercollider_lsp = {
    cmd = { "python", "/home/neum/Documenti/SC-LSP/example_server.py" }, -- Update with the server's path
    filetypes = { "supercollider" }, -- File type for SuperCollider
    root_dir = lspconfig.util.root_pattern(".git", "."), -- Define the root directory
    on_attach = function(client, bufnr)
        -- Enable LSP-related keybindings
        local bufmap = function(mode, lhs, rhs)
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
        end

        bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
        bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    end,
}

vim.filetype.add({
    extension = {
        scd = "supercollider",
    },
})
