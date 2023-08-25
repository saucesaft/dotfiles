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
	'nvim-tree/nvim-tree.lua',
	requires = 'nvim-tree/nvim-web-devicons'
    }

    --- fzf
    use {
	'nvim-telescope/telescope.nvim', tag = '0.1.2',
	requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
	'tom-anders/telescope-vim-bookmarks.nvim',
	requires = { 'MattesGroeger/vim-bookmarks' }
	}

    --- lsp
    use {
	'neovim/nvim-lspconfig',
	}

    --- when i dont want to code
    use {
	'eandrju/cellular-automaton.nvim',
	requires = 'nvim-treesitter/nvim-treesitter'
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
	    require('alpha').setup(require'alpha.themes.dashboard'.config)
	end
    }

    use {
	"mcchrish/zenbones.nvim",
	requires = "rktjmp/lush.nvim"
    }

    use {
	"evanleck/vim-svelte",
	requires = {"othree/html5.vim", "pangloss/vim-javascript"},
	}

    use "habamax/vim-rst"

    -- colorscheme

    use "morhetz/gruvbox"

    -- jinja syntax
    use "Glench/Vim-Jinja2-Syntax"

    -- buffer line and managment

    use 'famiu/bufdelete.nvim'

    use {
	'akinsho/bufferline.nvim',
	tag = "v2.*",
	requires = 'kyazdani42/nvim-web-devicons'
    }

    -- snippets and latex things

    use {
	"L3MON4D3/LuaSnip",
	tag = "v<CurrentMajor>.*"
    }

    use 'lervag/vimtex'

    use {
      "iurimateus/luasnip-latex-snippets.nvim",
      -- replace "lervag/vimtex" with "nvim-treesitter/nvim-treesitter" if you're
      -- using treesitter.
      requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
      config = function()
	require'luasnip-latex-snippets'.setup()
	-- or setup({ use_treesitter = true })
      end,
      ft = "tex",
    }

  end
)
