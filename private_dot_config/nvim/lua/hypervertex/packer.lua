-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use({ 'rose-pine/neovim', as = 'rose-pine', })
	use({ 'dracula/vim', as = 'dracula', })

	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
	use('nvim-treesitter/playground')
	use('mbbill/undotree')
	use('tpope/vim-fugitive')

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{                                      -- Optional
			    'williamboman/mason.nvim',
			    run = function()
				    pcall(vim.cmd, 'MasonUpdate')
			    end,
		    },
		    {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
	    }
    }

    use('scrooloose/nerdtree', { on = 'NERDTreeToggle' })

    use('tpope/vim-surround')
    use('tpope/vim-repeat')
    use('tpope/vim-commentary')
    use('itchyny/lightline.vim')
    use('christoomey/vim-tmux-navigator')
    use('tmux-plugins/vim-tmux-focus-events')

    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
end)
