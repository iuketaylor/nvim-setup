return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
			automatic_setup = false,
			-- Explicitly exclude denols since deno-nvim handles it
			ensure_installed = {
				"biome",
				-- Add other servers you want, but NOT denols
				-- "lua_ls", "pyright", "rust_analyzer", etc.
			},
		},
	},
	{
		"sigmaSd/deno-nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
		config = function()
			require("deno-nvim").setup({
				server = {
					capabilities = require("cmp_nvim_lsp").default_capabilities(),
					cmd = { "deno", "lsp" }, -- Use system deno
					root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc"),
					settings = {
						deno = {
							enable = true,
							lint = true,
							unstable = true,
							suggest = {
								imports = {
									hosts = {
										["https://deno.land"] = true,
										["https://crux.land"] = true,
										["https://x.nest.land"] = true,
									},
								},
							},
						},
					},
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local util = require("lspconfig.util")

			-- Configure ts_ls to work alongside Biome
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				root_dir = function(fname)
					-- First check if we're in a Deno project
					local deno_root = util.root_pattern("deno.json", "deno.jsonc")(fname)
					if deno_root then
						return nil -- Don't attach ts_ls in Deno projects
					end
					-- Only attach to Node.js projects with package.json
					local package_root = util.root_pattern("package.json")(fname)
					if package_root then
						return package_root
					end
					return nil -- Don't attach if no package.json found
				end,
				single_file_support = false, -- Prevent attachment to single files
				-- Disable ts_ls diagnostics when Biome is present
				on_attach = function(client, bufnr)
					-- Check if Biome LSP is also attached to this buffer
					local biome_attached = false
					for _, lsp_client in pairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
						if lsp_client.name == "biome" then
							biome_attached = true
							break
						end
					end
					
					-- If Biome is attached, disable ts_ls diagnostics to avoid conflicts
					if biome_attached then
						client.server_capabilities.diagnosticProvider = false
					end
				end,
			})

			-- Configure Biome LSP
			lspconfig.biome.setup({
				capabilities = capabilities,
			})

			-- Your existing keybindings
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {})

			-- Deno-specific keybinding for running tests
			vim.keymap.set("n", "<space>dr", function()
				vim.lsp.codelens.refresh()
				vim.lsp.codelens.run()
			end, { desc = "Run Deno tests" })

			-- Force stop ts_ls in Deno projects - multiple event triggers for reliability
			local function detach_tsls_from_deno()
				local util = require("lspconfig.util")
				local current_buf = vim.api.nvim_get_current_buf()
				local deno_root = util.root_pattern("deno.json", "deno.jsonc")(vim.api.nvim_buf_get_name(current_buf))

				if deno_root then
					-- We're in a Deno project, detach any ts_ls clients
					for _, client in pairs(vim.lsp.get_active_clients({ bufnr = current_buf })) do
						if client.name == "ts_ls" then
							vim.lsp.buf_detach_client(current_buf, client.id)
							print("Detached ts_ls from Deno project")
						end
					end
				end
			end

			-- Trigger on multiple events to catch ts_ls attachment
			vim.api.nvim_create_autocmd({ "BufEnter", "LspAttach" }, {
				pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
				callback = function()
					vim.defer_fn(detach_tsls_from_deno, 200)
				end,
			})
		end,
	},
}
