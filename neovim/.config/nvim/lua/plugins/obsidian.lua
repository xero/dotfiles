return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	-- ft = "markdown",
	event = {
		"BufReadPre " .. vim.fn.expand("~") .. "/.local/src/notes/*.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/.local/src/notes/*.md",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"hrsh7th/nvim-cmp",
	},
	init = function()
		vim.opt.conceallevel = 1
	end,
	opts = {
		workspaces = {
			{
				name = "notes",
				path = "~/.local/src/notes",
			},
		},
		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},
		mappings = {
			-- overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			-- toggle check-boxes.
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
			-- smart action depending on context, either follow link or toggle checkbox.
			["<cr>"] = {
				action = function()
					return require("obsidian").util.smart_action()
				end,
				opts = { buffer = true, expr = true },
			},
		},
		note_frontmatter_func = function(note)
			if note.title then
				note:add_alias(note.title)
			end
			local out = { id = note.id, aliases = note.aliases, tags = note.tags }
			-- ensure fields are kept in the frontmatter
			if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
				for k, v in pairs(note.metadata) do
					out[k] = v
				end
			end
			return out
		end,
		follow_url_func = function(url)
			vim.fn.jobstart({ "yank", url })
		end,
		follow_img_func = function(img)
			vim.fn.jobstart({ "yank", img })
		end,
		picker = {
			name = "telescope.nvim",
			-- note_mappings = {
			-- 	-- create a new note from your query.
			-- 	new = "<C-n>",
			-- 	-- insert a link to the selected note.
			-- 	insert_link = "<C-l>",
			-- },
			-- tag_mappings = {
			-- 	tag_note = "<C-x>",
			-- 	insert_tag = "<C-l>",
			-- },
		},
		sort_by = "modified",
		sort_reversed = true,
		search_max_lines = 1000,
		open_notes_in = "current", -- vsplit|hsplit
	},
}
