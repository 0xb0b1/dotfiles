local config = require "better-vim.better-vim"
local default_config = require "better-vim-core.default-config"

local M = {}

M.file_exists = function(name)
  local file = io.open(name, "r")
  if file ~= nil then
    io.close(file)
    return true
  else
    return false
  end
end

M.get_config_item = function(keys)
  local value = config
  local defaultValue = default_config

  for _, key in ipairs(keys) do
    if value[key] ~= nil then
      value = value[key]
    else
      value = defaultValue[key]
    end

    defaultValue = defaultValue[key]
  end

  return value
end

M.table_length = function(table)
  local _table = table or {}
  local count = 0
  for _ in pairs(_table) do
    count = count + 1
  end
  return count
end

M.merge_tables = function(...)
  local tables_to_merge = { ... }
  assert(#tables_to_merge > 1, "There should be at least two tables to merge them")

  for k, t in ipairs(tables_to_merge) do
    assert(type(t) == "table", string.format("Expected a table as function parameter %d", k))
  end

  local result = tables_to_merge[1]

  for i = 2, #tables_to_merge do
    local from = tables_to_merge[i]
    for k, v in pairs(from) do
      if type(k) == "number" then
        table.insert(result, v)
      elseif type(k) == "string" then
        if type(v) == "table" then
          result[k] = result[k] or {}
          result[k] = M.merge_tables(result[k], v)
        else
          result[k] = v
        end
      end
    end
  end

  return result
end

M.ternary = function(cond, true_expression, false_expression)
  if cond then
    return true_expression
  else
    return false_expression
  end
end

M.shallow_merge = function(table1, table2)
  local new_table = {}

  for k, v in pairs(table1) do
    new_table[k] = v
  end

  for k, v in pairs(table2) do
    new_table[k] = M.ternary(v == "remove", nil, v)
  end

  return new_table
end

M.with_leader_as_prefix = function(key)
  local leader = M.get_config_item { "mappings", "leader" }
  local label = leader == " " and "<SPACE>" or leader

  return label .. key
end

M.is_loaded = function(plugin_key)
  local unload_plugins_table = M.get_config_item { "unload_plugins" }

  for _, k in pairs(unload_plugins_table) do
    if plugin_key == k then
      return false
    end
  end

  return true
end

M.unloadable_by_key = function(plugin_key, plugin_config)
  if M.is_loaded(plugin_key) then
    return plugin_config
  end

  return {}
end

M.is_a_prerelease = function(version)
  return string.match(version, "[-v](%d+)$") ~= nil
end

-- only load the selected theme
local theme_name = M.get_config_item { "theme", "name" }
M.should_load_theme = function(name, theme)
  return M.ternary(theme_name == name, theme, {})
end

M.should_load_by_flag = function(flag, tbl)
  return M.ternary(M.get_config_item { "flags", flag } == true, tbl, {})
end


return M
