local set = vim.opt

-- mouse support
set.mouse = 'a'

-- line numbers
set.number = true

-- true colors
set.termguicolors = true

-- set shift width
set.shiftwidth = 4

-- set tab as leader
vim.g.mapleader = '\t'

-- change cursor back to normal
vim.cmd('au VimLeave * set guicursor=a:ver1-blinkon0')





