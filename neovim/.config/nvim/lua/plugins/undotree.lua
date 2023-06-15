return {
	'mbbill/undotree',
	lazy = true,
	keys = {{ "<leader>u", vim.cmd.UndotreeToggle, desc = "undotree" }},
	cmd = {
		'UndotreeToggle',
	},
}
