vim.cmd[[
  set background=light
  colorscheme rosebones
]]

require("bufferline").setup{
    options = {
	modified_icon = ':v',
	close_icon = 'X',
	show_buffer_icons = false,
    }
}

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
})

local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

require('lualine').setup {}
