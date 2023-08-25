-- please replace with native lua
vim.cmd[[
" Use Tab to expand and jump through snippets
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'

" Use Shift-Tab to jump backwards through snippets
imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
]]

require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/snips/"})

require("luasnip").config.set_config({

  -- enable autotriggered snippets
  enable_autosnippets = true,

  -- use tab (or some other key if you prefer) to trigger visual selection
  store_selection_keys = "<Tab>",
})
