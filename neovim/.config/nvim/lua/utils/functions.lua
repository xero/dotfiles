local vim = vim

local M = {}

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

function M.starts_with(str, start)
  return str:sub(1, #start) == start
end

function M.is_table(to_check)
  return type(to_check) == "table"
end

function M.has_key(t, key)
  for t_key, _ in pairs(t) do
    if t_key == key then
      return true
    end
  end

  return false
end

function M.has_value(t, val)
  for _, value in ipairs(t) do
    if value == val then
      return true
    end
  end

  return false
end

function M.tprint(table)
  print(vim.inspect(table))
end

function M.tprint_keys(table)
  for k in pairs(table) do
    print(k)
  end
end

M.reload = function()
  local presentReload, reload = pcall(require, "plenary.reload")
  if presentReload then
    local counter = 0

    for moduleName in pairs(package.loaded) do
      if M.starts_with(moduleName, "lt.") then
        reload.reload_module(moduleName)

        counter = counter + 1
      end
    end

    -- clear nvim-mapper keys
    vim.g.mapper_records = nil

    vim.notify("Reloaded " .. counter .. " modules!")
  end
end

function M.is_macunix()
  return vim.fn.has("macunix")
end

function M.link_highlight(from, to, override)
  local hl_exists, _ = pcall(vim.api.nvim_get_hl_by_name, from, false)
  if override or not hl_exists then
    -- vim.cmd(("highlight link %s %s"):format(from, to))
    vim.api.nvim_set_hl(0, from, { link = to })
  end
end

M.highlight = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

M.highlight_bg = function(group, col)
  vim.api.nvim_set_hl(0, group, { bg = col })
end

-- Define fg color
-- @param group Group
-- @param color Color
M.highlight_fg = function(group, col)
  vim.api.nvim_set_hl(0, group, { fg = col })
end

-- Define bg and fg color
-- @param group Group
-- @param fgcol Fg Color
-- @param bgcol Bg Color
M.highlight_fg_bg = function(group, fgcol, bgcol)
  vim.api.nvim_set_hl(0, group, { bg = bgcol, fg = fgcol })
end

M.from_highlight = function(hl)
  local result = {}
  local list = vim.api.nvim_get_hl_by_name(hl, true)
  for k, v in pairs(list) do
    local name = k == "background" and "bg" or "fg"
    result[name] = string.format("#%06x", v)
  end
  return result
end

M.get_color_from_terminal = function(num, default)
  local key = "terminal_color_" .. num
  return vim.g[key] and vim.g[key] or default
end

return M
