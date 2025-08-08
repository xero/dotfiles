return {
  'ibhagwan/fzf-lua',
	event = "VeryLazy",
	dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { "<leader>/c",  function() require("fzf-lua").commands() end,        desc = "search commands" },
    { "<leader>/C",  function() require("fzf-lua").command_history() end, desc = "search command history" },
    { "<leader>/f",  function() require("fzf-lua").files() end,           desc = "search old files" },
    { "<leader>/h",  function() require("fzf-lua").highlights() end,      desc = "search highlights" },
    { "<leader>/M",  function() require("fzf-lua").marks() end,           desc = "search marks" },
    { "<leader>/k",  function() require("fzf-lua").keymaps() end,         desc = "search keymaps" },
    { "<leader>//",  function() require("fzf-lua").live_grep() end,       desc = "live grep" },
    { "<leader>/gf", function() require("fzf-lua").git_files() end,       desc = "search git file names" },
    { "<leader>/gb", function() require("fzf-lua").git_branches() end,    desc = "search git branches" },
    { "<leader>/gc", function() require("fzf-lua").git_commits() end,     desc = "search git commits" },
    { "<leader>/gC", function() require("fzf-lua").git_bcommits() end,    desc = "search git buffer commits" },
    { "<leader>/r",  function() require("fzf-lua").resume() end,          desc = "resume fzf" },
  },
  config = function()
    local fzf = require('fzf-lua')
		fzf.setup({
      keymap = {
        fzf = {
          ['CTRL-Q'] = 'select-all+accept',
        },
      },
    })
    fzf.register_ui_select()
		require("utils.remaps").map_virtual({
			{ "<leader>/", group = "fzf", icon = { icon = "󰮫", hl = "Constant" } },
			{ "<leader>/g", group = "git", icon = { icon = "", hl = "Boolean" } },
		})
  end,
}
