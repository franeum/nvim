local ls = require("luasnip")

ls.add_snippets( "all", {
	ls.parser.parse_snippet(
		'func',
        	'function ${1}(${2}) \n{\n\t${3}\n}'
	)
})

vim.keymap.set(
    'i',
    '<c-p>',
    function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end
)

