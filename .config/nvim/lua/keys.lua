local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }



-- Move to previous/next
map('n', '<Leader>[', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<Leader>]', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<Leader>{', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<Leader>}', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<Leader>1', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<Leader>2', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<Leader>3', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<Leader>4', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<Leader>5', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<Leader>6', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<Leader>7', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<Leader>8', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<Leader>9', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<Leader>0', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<Leader>p', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<Leader>w', '<Cmd>BufferClose<CR>', opts)

-- reload config
map('n', '<Leader>rc', '<Cmd>source $MYVIMRC<CR>', opts)

-- activate cellular automata
map('n', '<Leader>fml', '<Cmd>CellularAutomaton make_it_rain<CR>', opts)

-- telescope mappings
-- local builtin = require('telescope.builtin')
-- local book = require('telescope').extensions.vim_bookmarks
-- luamap('n', '<Leader>ba', book.all)

-- local wk = require("which-key")
--
-- wk.register(mappings, opts)
