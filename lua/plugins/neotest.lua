return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"marilari88/neotest-vitest",
	},
	keys = {
		-- Run nearest test
		{
			"<leader>tr",
			function()
				require("neotest").run.run()
			end,
			desc = "Run nearest test",
		},

		-- Run all tests in current file
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run test file",
		},

		-- Run all tests in the suite
		{
			"<leader>ta",
			function()
				require("neotest").run.run(vim.fn.getcwd())
			end,
			desc = "Run all tests",
		},

		-- Toggle watch mode for all tests
		{
			"<leader>tw",
			function()
				require("neotest").watch.toggle(vim.fn.getcwd())
			end,
			desc = "Toggle watch mode (all tests)",
		},

		-- Toggle output window
		{
			"<leader>to",
			function()
				require("neotest").output.open({ enter = true })
			end,
			desc = "Open test output",
		},

		-- Toggle summary sidebar
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle test summary",
		},
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-vitest")({
					vitestCommand = "pnpm vitest",
				}),
			},
			summary = {
				open = "topleft vsplit | vertical resize 80",
			},
			discovery = {
				enabled = true,
			},
		})

		-- Set relative line numbers in summary panel
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "neotest-summary",
			callback = function()
				vim.opt_local.relativenumber = true
				vim.opt_local.number = true
			end,
		})
	end,
}
