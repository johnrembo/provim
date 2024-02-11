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
        use({
            "nvim-lualine/lualine.nvim",
            requires = { "nvim-tree/nvim-web-devicons", opt = true },
        })

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

        -- language tool
        use("dpelle/vim-LanguageTool")

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
        use("windwp/nvim-autopairs")                                 -- autoclose parens, brackets, quotes, etc...
        use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

        -- git integration
        use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side
        use({
            "kdheepak/lazygit.nvim",
            requires = {
                "nvim-telescope/telescope.nvim",
                "nvim-lua/plenary.nvim",
            },
            -- config = function()
            -- 	require("telescope").load_extension("lazygit")
            -- end,
        })

        -- fuzzy finding telescope
        use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
        use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })        -- fuzzy finder

        -- import .env file
        use("tpope/vim-dotenv")

        -- import .editorconfig file
        use("editorconfig/editorconfig-vim")

        -- lsp

        use("neovim/nvim-lspconfig")
        use("ray-x/guihua.lua")
        use({
            "ray-x/navigator.lua",
            requires = {
                { "ray-x/guihua.lua",     run = "cd lua/fzy && make" },
                { "neovim/nvim-lspconfig" },
            },
        })
        use("ray-x/lsp_signature.nvim")

        -- autocomplete
        use("hrsh7th/cmp-nvim-lsp")
        use({
            "SmiteshP/nvim-navic",
            requires = "neovim/nvim-lspconfig",
        })

        use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion
        use("hrsh7th/cmp-omni")     -- file type omni
        use("hrsh7th/cmp-buffer")   -- source for text in buffer
        use("hrsh7th/cmp-path")     -- source for file system paths
        use("f3fora/cmp-spell")     -- spelling
        use("hrsh7th/cmp-cmdline")  -- command line
        use("hrsh7th/nvim-cmp")     -- completion plugin
        use("L3MON4D3/LuaSnip")
        use("saadparwaiz1/cmp_luasnip")

        -- refactoring
        use({
            "ThePrimeagen/refactoring.nvim",
            requires = {
                { "nvim-lua/plenary.nvim" },
                { "nvim-treesitter/nvim-treesitter" },
            },
        })

        use("adoy/vim-php-refactoring-toolbox")

        -- formatting
        use({
            "jose-elias-alvarez/null-ls.nvim",
            config = function()
                require("null-ls").setup()
            end,
            requires = { "nvim-lua/plenary.nvim" },
        })


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
            cmd = {
                "DBUIToggle",
                "DBUI",
                "DBUIAddConnection",
                "DBUIFindBuffer",
                "DBUIRenameBuffer",
                "DBUILastQueryInfo",
            },
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
