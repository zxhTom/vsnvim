return {
  "AstroNvim/astrocore",
  lazy = false, -- disable lazy loading
  priority = 10000, -- load AstroCore first
  opts = require("config.astrocore"),
}
