-- ▄█▀▀▄ ▄█▀█ ▄█▀▀▄ ▄█ █ ▄█ ▄█▄ ▄█
-- ▓█  █ ▓█▄  ▓█  █ ▓█ █ ▓█ ▓█ ▀ █
-- ▓█  █ ▓█ ▄ ▓█  █ ▓█ █ ▓█ ▓█   █
-- ▓█  █ ▓█▄█ ▀█▄▄▀ ▀█▄▀ ▓█ ▓█   █
--
-- ░ config from xero's dotfiles
-- ▒ author: xero (x@xero.style)
-- ▓ https://git.io/.files
-- █ https://code.x-e.ro/dotfiles

local profiles = {
	work = "CLAUDE_CONFIG_DIR=~/.claudework claude",
	personal = "CLAUDE_CONFIG_DIR=~/.claude claude",
}

local active_profile = "work"

local function kill_existing_terminal()
	local cc = require("claude-code")
	for id, bufnr in pairs(cc.claude_code.instances) do
		if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
			local win_ids = vim.fn.win_findbuf(bufnr)
			for _, win_id in ipairs(win_ids) do
				pcall(vim.api.nvim_win_close, win_id, true)
			end
			pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
		end
		cc.claude_code.instances[id] = nil
	end
end

local function set_profile(name)
	if not profiles[name] then
		vim.notify("Claude: unknown profile '" .. name .. "'", vim.log.levels.ERROR)
		return
	end
	local cc = require("claude-code")
	if name ~= active_profile then
		kill_existing_terminal()
		active_profile = name
	end
	cc.config.command = profiles[name]
	cc.toggle()
end

return {
	"greggh/claude-code.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("claude-code").setup({
			window = {
				split_ratio = 0.42,
				position = "vertical",
				enter_insert = false,
				hide_numbers = true,
				hide_signcolumn = true,
			},
			refresh = {
				enable = true,
				updatetime = 100,
				timer_interval = 1000,
				show_notifications = true,
			},
			git = {
				use_git_root = true,
			},
			shell = {
				separator = '&&',
				pushd_cmd = 'pushd',
				popd_cmd = 'popd',
			},
			-- Command used to launch Claude Code
			command = profiles[active_profile],
			command_variants = {
				continue = "--continue",
				resume = "--resume",
				verbose = "--verbose",
			},
			-- Keymaps
			keymaps = {
				toggle = {
					normal = false,
					terminal = false,
				},
				window_navigation = true,
				scrolling = true,
			}
		})

		vim.api.nvim_create_user_command("ClaudeWork", function()
			set_profile("work")
		end, { desc = "Open Claude Code with work profile" })

		vim.api.nvim_create_user_command("ClaudePersonal", function()
			set_profile("personal")
		end, { desc = "Open Claude Code with personal profile" })

		vim.api.nvim_create_user_command("ClaudeSwitch", function()
			vim.ui.select(vim.tbl_keys(profiles), {
				prompt = "Claude profile:",
				format_item = function(name)
					local marker = name == active_profile and " (active)" or ""
					return name .. marker
				end,
			}, function(choice)
				if choice then
					set_profile(choice)
				end
			end)
		end, { desc = "Pick a Claude Code profile" })
	end
}
