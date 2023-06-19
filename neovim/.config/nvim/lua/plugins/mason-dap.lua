return {
	"jay-babu/mason-nvim-dap.nvim",
	dependencies = { "williamboman/mason.nvim" },
	cmd = "Mason",
	config = function()
		local mason_dap = require("mason-nvim-dap")
		mason_dap.setup({
			ensure_installed = {
				"bash",
				"cppdbg",
				"js",
				"node2",
				"php",
				"python",
			},
			auto_update = false,
			run_on_start = false,
			automatic_setup = true,
		})
		mason_dap.setup_handlers {}
	end,
}
