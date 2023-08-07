local functions = require("utils.functions")

local X = {}

local duplicates_n = {}
local duplicates_v = {}
local duplicates_i = {}
local duplicates_s = {}
local duplicates_x = {}

local function check_and_set_duplicates(input, description, check, table)
	if check then
		local found = table[input]

		if found ~= nil then
			if found ~= description then
				print(input .. " already mapped (" .. found .. " so we cannot re-map (" .. description .. ")")
			end
		end

		table[input] = description
	end
end

X.check_duplicates = function(type, input, description)
	local check_n = false
	local check_v = false
	local check_i = false
	local check_s = false
	local check_x = false

	if functions.is_table(type) then
		if type["n"] then
			check_n = true
		end
		if type["v"] then
			check_v = true
		end
		if type["i"] then
			check_i = true
		end
		if type["s"] then
			check_s = true
		end
		if type["x"] then
			check_x = true
		end
	else
		if type == "n" then
			check_n = true
		end
		if type == "v" then
			check_v = true
		end
		if type == "i" then
			check_i = true
		end
		if type == "s" then
			check_s = true
		end
		if type == "x" then
			check_x = true
		end
	end

	check_and_set_duplicates(input, description, check_n, duplicates_n)
	check_and_set_duplicates(input, description, check_v, duplicates_v)
	check_and_set_duplicates(input, description, check_i, duplicates_i)
	check_and_set_duplicates(input, description, check_s, duplicates_s)
	check_and_set_duplicates(input, description, check_x, duplicates_x)
end

return X
