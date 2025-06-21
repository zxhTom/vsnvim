local M = {}
M.setup = function(module)
  pcall(require, "setup." .. module)
end
M.keyboards = function(module)
  pcall(require, "keyboards." .. module)
end
M.config = function(module)
  pcall(require, "config." .. module)
end
M.all = function(module)
  M.setup(module)
  M.config(module)
end
return M
