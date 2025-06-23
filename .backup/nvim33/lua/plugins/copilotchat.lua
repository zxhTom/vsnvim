---@type LazySpec
return {
  "CopilotC-Nvim/CopilotChat.nvim",
  version = "^3",
  cmd = {
    "CopilotChat",
    "CopilotChatOpen",
    "CopilotChatClose",
    "CopilotChatToggle",
    "CopilotChatStop",
    "CopilotChatReset",
    "CopilotChatSave",
    "CopilotChatLoad",
    "CopilotChatDebugInfo",
    "CopilotChatModels",
    "CopilotChatAgents",
    "CopilotChatExplain",
    "CopilotChatReview",
    "CopilotChatFix",
    "CopilotChatOptimize",
    "CopilotChatDocs",
    "CopilotChatFixTests",
    "CopilotChatCommit",
  },
  dependencies = {
    { "zbirenbaum/copilot.lua" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },
  },
  config = function()
    -- 确保所有依赖加载完成后再初始化
    require('utils.import').all('copilotchat')
  end,
}
