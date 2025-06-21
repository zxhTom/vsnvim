-- ~/.config/nvim/lua/user/utils/config_loader.lua
local M = {}

-- 安全加载 Lua 模块
local function safe_require(name)
  local ok, mod = pcall(require, name)
  return ok and mod or nil
end

-- 递归合并表格（深度合并）
local function deep_merge(t1, t2)
  for k, v in pairs(t2) do
    if type(v) == "table" and type(t1[k]) == "table" then
      deep_merge(t1[k], v)
    else
      t1[k] = v
    end
  end
  return t1
end

-- 加载并合并目录下的所有配置
function M.load_configs(dir_path)
  local merged = {}
  local scanned_files = {}

  -- 扫描 lua 目录
  local config_dir = vim.fn.stdpath("config") .. "/lua/" .. dir_path:gsub("%.", "/")
  local files = vim.fn.glob(config_dir .. "/*.lua", false, true)

  for _, file in ipairs(files) do
    -- 提取模块名（去掉路径和扩展名）
    local module = file:match(".*/([^/]+)%.lua$")
    if module and module ~= "init" then
      local mod_path = dir_path .. "." .. module
      local config = safe_require(mod_path)
      if type(config) == "table" then
        deep_merge(merged, config)
        table.insert(scanned_files, mod_path)
      end
    end
  end

  return merged, scanned_files
end

return M
