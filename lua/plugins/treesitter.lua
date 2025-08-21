return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
  config = function ()
    require("nvim-treesitter.configs").setup({
        highlight = {
        enable = true,
      },
      indent = {
        enable = true,  -- This enables treesitter-based indentation
      },
    })

  end
}
