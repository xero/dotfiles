local keymap = vim.keymap
local X = {}
local wk_lazy = {}

local function lazy_register_wk(input)
	table.insert(wk_lazy, input)
end

local function add_wk(input)
	local wk_ready, wk = pcall(require, "which-key")
	if wk_ready and wk.did_setup then
		if wk_lazy ~= {} then
			lazy_register_wk(input)
			wk.add(wk_lazy)
			wk_lazy = {}
		end
	else
		lazy_register_wk(input)
	end
end

function X.map(type, input, output, description, additional_options)
	local options = { remap = true, desc = description }
	if additional_options then
		options = vim.tbl_deep_extend("force", options, additional_options)
	end
	keymap.set(type, input, output, options)
end

function X.noremap(type, input, output, description, additional_options)
	local options = { remap = false }
	if additional_options then
		options = vim.tbl_deep_extend("force", options, additional_options)
	end
	X.map(type, input, output, description, options)
end

function X.map_virtual(input)
	add_wk(input)
end

return X
