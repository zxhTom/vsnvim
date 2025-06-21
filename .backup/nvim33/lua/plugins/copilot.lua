return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  lazy = "false",
  config = function()
    require "utils.import".all("copilot")
  end,
}
