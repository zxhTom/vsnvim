  local M ={}
  M.setup = function(module)
    require("setup."..module)
  end
  M.keyboards = function(module)
    require("keyboards."..module)
  end
  M.config = function(module)
    require("config."..module)
  end
  M.all = function(module)
    M.setup(module)
    M.config(module)
    M.keyboards(module)
  end
  return M
