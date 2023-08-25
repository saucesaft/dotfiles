local set = vim.opt

-- mouse support
set.mouse = 'a'

-- line numbers
set.number = true

-- true colors
set.termguicolors = true

-- set shift width
set.shiftwidth = 4

-- change cursor back to normal when leaving neovim
vim.cmd('au VimLeave * set guicursor=a:ver1-blinkon0')

-- vimtex specific settings
vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'skim'
vim.g.vimtex_view_skim_sync = 1
vim.g.vimtex_view_skim_activate = 1

-- set xml syntax and commenting for .launch files
vim.cmd('au BufRead,BufNewFile *.launch set filetype=xml')
require('Comment.ft').set('launch', '<!--%s-->')

-- load telescope extension
require('telescope').load_extension('vim_bookmarks')
