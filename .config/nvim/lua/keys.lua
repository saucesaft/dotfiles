-- map key to vim command
function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- map key to lua function
function luamap(mode, lhs, func, opts)
    local options = { noremap = true }
    if opts then
	options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, func, options)
end

-- alt + tab = focus tree
map('n', '<A-Tab>', ':NvimTreeFocus<CR>')

-- leader + t = toggle tree
map('n', '<Leader>t', ':NvimTreeFindFileToggle<CR>', {silent = true})

-- leader + w = close buffer
luamap('n', '<Leader>w', require('bufdelete').bufdelete)

-- leader + ([) or (]) to move to left or right buffer
map('n', '<Leader>[', ":bprevious<CR>", {silent = true})
map('n', '<Leader>]', ":bnext<CR>", {silent = true})

-- leader + ({) or }) to change buffer order left or right
map('n', '<Leader>{', ":BufferLineMovePrev<CR>", {silent = true})
map('n', '<Leader>}', ":BufferLineMoveNext<CR>", {silent = true})

-- reload config
map('n', '<Leader>rc', ':source $MYVIMRC<CR>')

-- activate cellular automata
map('n', '<Leader>fml', ':CellularAutomaton make_it_rain<CR>')

-- telescope mappings
local builtin = require('telescope.builtin')
local book = require('telescope').extensions.vim_bookmarks

luamap('n', '<Leader>ff', builtin.find_files)
luamap('n', '<Leader>fd', builtin.lsp_document_symbols)
luamap('n', '<Leader>fw', builtin.lsp_workspace_symbols)
luamap('n', '<Leader>dd', builtin.lsp_definitions)
luamap('n', '<Leader>bb', book.current_file)
luamap('n', '<Leader>ba', book.all)

-- local wk = require("which-key")
--
-- wk.register(mappings, opts)
