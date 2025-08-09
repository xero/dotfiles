-- ██╗      █████╗ ███████╗██╗   ██╗         Z
-- ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝      Z
-- ██║     ███████║  ███╔╝  ╚████╔╝    z
-- ██║     ██╔══██║ ███╔╝    ╚██╔╝   z
-- ███████╗██║  ██║███████╗   ██║
-- ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		require("ui.colorschemes"),
		require("core.mason"),
		require("lsp.init"),
		require("core.snacks"),
		require("core.yank"),
		require("core.blink"),
		require("core.tmux"),
		require("core.telescope"),
		require("core.surround"),
		require("core.conform"),
		require("core.trouble"),
		require("ui.whichkey"),
		require("ui.lualine"),
		require("ui.devicons"),
		require("ui.ansi"),
		require("ui.colorizer"),
		require("ui.lush"),
		require("core.match"),
		require("core.fzf"),
		require("core.git"),
		require("core.copilot"),
		require("core.dadbod"),
		require("core.treesj"),
		require("ui.signs"),
		require("ui.tint"),
		require("ui.treesitter"),
	},
	dev = {
		path = "~/.local/src",
	},
	lockfile = vim.fn.stdpath("config") .. "/lua/cfg/pkglock.json",
	ui = {
		size = { width = 0.8, height = 0.8 },
		wrap = true,
		border = "shadow",
		icons = require("utils.icons").lazy,
	},
	performance = {
		reset_packpath = true,
		cache = {
			enabled = true,
		},
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

local loader = require("lazy.core.loader")
local config = require("lazy.core.config")
local function disable_all_plugins()
  for _, plugin in pairs(config.plugins) do
    if plugin._.loaded then
      loader.deactivate(plugin)
    end
  end
end
vim.api.nvim_create_user_command("LazyDisable", disable_all_plugins, {})
