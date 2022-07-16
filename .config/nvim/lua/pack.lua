local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn

-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end

vim.cmd('packadd packer.nvim')

local packer = require'packer'
local util = require'packer.util'

packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

--- startup and add configure plugins
packer.startup(function()
    local use = use
    use {
	'nvim-lualine/lualine.nvim',
	requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {
	'levelone/tequila-sunrise.vim'
    }

    use {
	'akinsho/bufferline.nvim',
	tag = "v2.*",
	requires = 'kyazdani42/nvim-web-devicons'
    }

    use {
	'kyazdani42/nvim-tree.lua',
	requires = 'kyazdani42/nvim-web-devicons'
    }

    use {
	'github/copilot.vim'
    }

    use {
	'numToStr/Comment.nvim',
	config = function()
	    require('Comment').setup()
	end
    }

    use {
	'goolord/alpha-nvim',
	requires = 'kyazdani42/nvim-web-devicons',
	config = function ()
	    require'alpha'.setup(require'alpha.themes.dashboard'.config)
	end
    }

    use {
	"mcchrish/zenbones.nvim",
	-- Optionally install Lush. Allows for more configuration or extending the colorscheme
	-- If you don't want to install lush, make sure to set g:zenbones_compat = 1
	-- In Vim, compat mode is turned on as Lush only works in Neovim.
	requires = "rktjmp/lush.nvim"
    }

    use {
	"folke/which-key.nvim",
	config = function()
	require("which-key").setup {
	    -- your configuration comes here
	    -- or leave it empty to use the default settings
	    -- refer to the configuration section below
    	}
  end
}

    end
)
