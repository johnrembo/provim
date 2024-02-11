local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	vim.notify("Warning: handlers.lua - cmp_nvim_lsp not loaded")
	return
end
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
	local icons = require("core.icons")
	local signs = {

		{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
		{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
		{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
		{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = {
			prefix = " ●",
			source = "if_many", -- Or "always"
		},

		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "if_many", -- Or "always"
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})
end

local function attach_navic(client, bufnr)
	vim.g.navic_silence = true
	local status_ok, navic = pcall(require, "nvim-navic")
	if not status_ok then
		return
	end
	navic.attach(client, bufnr)
end

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>Telescope lsp_declarations<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
	vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]])
	vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gf", "<cmd>Lspsaga finder<CR>", opts) -- show definition, references
	vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts) -- smart rename
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	-- vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor

	local status_ok, which_key = pcall(require, "which-key")
	if not status_ok then
		print("Where is the which-key?")
		return
	end

	local l_opts = {
		mode = "n", -- NORMAL mode
		prefix = "<leader>",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = true, -- use `nowait` when creating keymaps
	}

	local l_mappings = {
		g = {
			name = "Goto",
			-- f = { "<cmd>Lspsaga finder<CR>", "Def and refs" },
			d = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
			-- D = { "<cmd>Lspsaga peek_definition<CR>", "Definition" },
			i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
		},
		l = {
			name = "LSP",
			-- a = { "<cmd>Lspsaga code_action<CR>", "Code action" },
			-- r = { "<cmd>Lspsaga rename<CR>", "Rename symbol" },
			-- D = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Line diags" },
			-- d = { "<cmd>Lspsaga show_cursor_diagnostics<CR>", "Cursor diags" },

			w = {
				"<cmd>Telescope lsp_workspace_diagnostics<cr>",
				"Workspace Diagnostics",
			},
			f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
			-- F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
			-- i = { "<cmd>LspInfo<cr>", "Info" },
			h = { "<cmd>lua require('lsp-inlayhints').toggle()<cr>", "Toggle Hints" },
			H = { "<cmd>IlluminationToggle<cr>", "Toggle Doc HL" },
			-- I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
			j = {
				"<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
				"Next Diagnostic",
			},
			k = {
				"<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
				"Prev Diagnostic",
			},
			v = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Virtual Text" },
			q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
			s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
			S = {
				"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
				"Workspace Symbols",
			},
			t = { '<cmd>lua require("plugins.functions").toggle_diagnostics()<cr>', "Toggle Diagnostics" },
			u = { "<cmd>LuaSnipUnlinkCurrent<cr>", "Unlink Snippet" },
		},
	}

	which_key.register(l_mappings, l_opts)
end

M.on_attach = function(client, bufnr)
	lsp_keymaps(bufnr)
	attach_navic(client, bufnr)

	if client.name == "tsserver" then
		require("lsp-inlayhints").on_attach(client, bufnr)
	end

	if client.name == "jdtls" then
		vim.lsp.codelens.refresh()
		require("jdtls").setup_dap({ hotcodereplace = "auto" })
		require("jdtls.dap").setup_dap_main_class_configs()
	end
end

function M.enable_format_on_save()
	vim.cmd([[
    augroup format_on_save
      autocmd! 
      autocmd BufWritePre * lua vim.lsp.buf.format({ async = false }) 
    augroup end
  ]])
	vim.notify("Enabled format on save")
end

function M.disable_format_on_save()
	M.remove_augroup("format_on_save")
	vim.notify("Disabled format on save")
end

function M.toggle_format_on_save()
	if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
		M.enable_format_on_save()
	else
		M.disable_format_on_save()
	end
end

function M.remove_augroup(name)
	if vim.fn.exists("#" .. name) == 1 then
		vim.cmd("au! " .. name)
	end
end

-- vim.cmd([[ command! LspToggleAutoFormat execute 'lua require("plugins.handlers").toggle_format_on_save()' ]])

return M
