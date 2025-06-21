local loader = require "utils.config_loader"
local opts, loaded_keyboards = loader.load_configs("keyboards")
-- print("Loaded mappings:", vim.inspect(loaded_keyboards))
return opts
