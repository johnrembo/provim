-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
    print("Packer not installed")
	return
end

-- add list of plugins to install
return packer.startup({
	function(use)
		-- packer can manage itself
		use("wbthomason/packer.nvim")

   		use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

   		use({
			"folke/which-key.nvim",
			config = function()
				require("which-key").setup({
					vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "#1f2335" }),
				})
			end,
		})

        -- vs-code like icons
        use("kyazdani42/nvim-web-devicons")

        -- statusline
        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'nvim-tree/nvim-web-devicons', opt = true }
        }
		
        -- tabline
		use("kdheepak/tabline.nvim")

		-- color schemes
		-- sonokai
		use("sainnhe/sonokai")
		-- forest
		use("sainnhe/vim-color-forest-night")
		-- 16 base color schemes
		use("Soares/base16.nvim")
		-- onehalf colorscheme
		use("sonph/onehalf")

		-- file explorer
		use("nvim-tree/nvim-tree.lua")

		-- tag bar
		use("majutsushi/tagbar")
        
        
   		use("easymotion/vim-easymotion")

		-- comments
		use("numToStr/Comment.nvim")

		-- tree sitter
		use({
			"nvim-treesitter/nvim-treesitter",
			run = function()
				require("nvim-treesitter.install").update({ with_sync = true })
			end,
		})

		-- auto closing
		use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
		use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

        -- git integration
		use("airblade/vim-gitgutter")
 
		-- fuzzy finding telescope
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
		use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

        -- import .env file
        use("tpope/vim-dotenv")

        -- import .editorconfig file
        use("editorconfig/editorconfig-vim")

        -- lsp
        use("neovim/nvim-lspconfig")
        -- use("dense-analysis/ale")
        -- use("prabirshrestha/vim-lsp")
        -- use("rhysd/vim-lsp-ale")
        
        use({
		"gbprod/phpactor.nvim",
		-- run = require("phpactor.handler.update"), -- To install/update phpactor when installing this plugin
		requires = {
			"nvim-lua/plenary.nvim", -- required to update phpactor
			"neovim/nvim-lspconfig" -- required to automaticly register lsp serveur
		},
		config = function()
	    	require("phpactor").setup({
                install = {
                    path = vim.fn.stdpath("data") .. "/opt/",
                    branch = "master",
                    bin = vim.fn.expand("$HOME/.local/bin/phpactor"),
                    php_bin = "php",
                    composer_bin = "composer",
                    git_bin = "git",
                    check_on_startup = "none",
                  },
                  lspconfig = {
                      enabled = true,
                      options = {},
                  },
		      -- your configuration comes here
		      -- or leave it empty to use the default settings
		      -- refer to the configuration section below
    		})
		end
	})

	-- autocomplete
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("null-ls").setup()
		end,
		requires = { "nvim-lua/plenary.nvim" },
	})

        use("hrsh7th/cmp-nvim-lsp")
        use("hrsh7th/cmp-buffer")
        use("hrsh7th/cmp-path")
        use("hrsh7th/cmp-cmdline")
        use("hrsh7th/nvim-cmp")
        use("L3MON4D3/LuaSnip")
        use("saadparwaiz1/cmp_luasnip")


		-- database

        use("vim-scripts/dbext.vim")

		use({
		    "tpope/vim-dadbod",
			opt = false,
            requires = {
                "kristijanhusak/vim-dadbod-ui",
                "kristijanhusak/vim-dadbod-completion",
            },
            config = function()
                require("plugins.dadbod").setup()
            end,
            cmd = { "DBUIToggle", "DBUI", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },            
		})

		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		git = {
			clone_timeout = 300, -- Timeout, in seconds, for git clones
		},
	},
})

