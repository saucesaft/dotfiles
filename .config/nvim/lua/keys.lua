-- tab = toggle recent buffers
-- shift + tab = focus tree
-- leader + t = toggle tree
-- leader + w = close buffer

function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<S-Tab>', ':NvimTreeFocus<CR>')

map('n', '<Leader>t', ':NvimTreeFindFileToggle<CR>', {silent = true})

map('n', '<Leader>w', ':bdelete<CR>')

-- local wk = require("which-key")
--
-- wk.register(mappings, opts)
