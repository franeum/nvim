local Plug = vim.fn['plug#']

vim.call('plug#begin')
Plug('neovim/nvim-lspconfig')
vim.call('plug#end')

local lsp = vim.lsp
local lspconfig = require('lspconfig')

-- "/home/neum/anaconda3/bin/python"

--[[
vim.lsp.start({
    name = 'sc-server',
    cmd = {'/home/neum/.config/nvim/new_server.py'},
    root_dir = vim.fs.root(0, {'pyproject.toml', 'setup.py'}),
    autostart = true
 })



lspconfig.supercollider_lsp = {
  cmd = { "/home/neum/anaconda3/bin/python", "/home/neum/.config/nvim/new_server.py" },
  filetypes = { "supercollider" },
  root_dir = function(fname)
    return vim.loop.cwd()
  end,
  on_attach = function(client, bufnr)
    print("SuperCollider LSP avviato!")
  end,
}

lspconfig.pyright.setup({
    on_attach = function(client, bufnr)
      print("Pyright LSP avviato!")
    end,
  })
]]--

-- Definisci il comando per avviare il server Python
local server_cmd = { 
    "/home/neum/anaconda3/bin/python", "/home/neum/.config/nvim/oldstyle.py"  -- Percorso al tuo script pygls
}

local configs = require 'lspconfig.configs'

-- Check if the config is already defined (useful when reloading this file)
if not configs.supercollider_lsp then
    configs.supercollider_lsp = {
    default_config = {
        cmd = server_cmd,
        filetypes = {'supercollider'},
        root_dir = function(fname)
            return vim.loop.cwd()
          end,
        settings = {},
    },
    }
end

--[[
lspconfig.supercollider_lsp.setup({
    cmd = server_cmd,             -- Comando per avviare il server
    filetypes = { "supercollider" }, -- Gestisce i file di tipo SuperCollider
    root_dir = function(fname)
      return vim.loop.cwd()        -- Usa la directory corrente come root del progetto
    end,
    on_attach = function(client, bufnr)
      print("SuperCollider LSP avviato!") -- Messaggio di connessione
    end,
    capabilities = vim.lsp.protocol.make_client_capabilities(), -- Capacità del client
  })
]]--

lspconfig.supercollider_lsp.setup({
    on_attach = function(client, bufnr)
        print("SuperCollider LSP avviato!") -- Messaggio di connessione
      end,
      capabilities = vim.lsp.protocol.make_client_capabilities()   
})