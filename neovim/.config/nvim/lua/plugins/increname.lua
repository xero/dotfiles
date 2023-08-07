return {
  "smjonas/inc-rename.nvim",
	lazy = true,
	cmd = {
		"IncRename",
	},
  config = function()
    require("inc_rename").setup()
  end,
}
