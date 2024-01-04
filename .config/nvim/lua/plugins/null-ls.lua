-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters
local completion = null_ls.builtins.completion -- to setup completion

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- user home
local home = os.getenv("HOME")

null_ls.setup({
    sources = {
        formatting.prettier,
        formatting.stylua,
        formatting.phpcbf,
        formatting.xmllint,
        formatting.google_java_format,
        diagnostics.eslint,
        completion.spell,
        -- null_ls.builtins.diagnostics.psalm.with({
        --     command = "vendor/bin/psalm",
        -- }),
    },
	-- configure format on save
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.format({
						filter = function(client)
							--  only use null-ls for formatting instead of lsp server
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
	timeout = 100000,
	timeout_ms = 100000,
	debug = true,
})

local defaults = {
    border = nil,
    cmd = { "nvim" },
    debounce = 250,
    debug = false,
    default_timeout = 5000,
    diagnostic_config = {},
    diagnostics_format = "#{m}",
    fallback_severity = vim.diagnostic.severity.ERROR,
    log_level = "warn",
    notify_format = "[null-ls] %s",
    on_attach = nil,
    on_init = nil,
    on_exit = nil,
    root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git"),
    should_attach = nil,
    sources = nil,
    temp_dir = nil,
    update_in_insert = false,
}
