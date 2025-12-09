return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {
		on_attach = function(client, bufnr)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
		end,
	},
}
