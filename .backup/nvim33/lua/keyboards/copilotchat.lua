-- 基础命令映射
local base_maps = {
  o = { ":CopilotChatOpen<CR>", "Open Chat" },
  c = { ":CopilotChatClose<CR>", "Close Chat" },
  t = { ":CopilotChatToggle<CR>", "Toggle Chat" },
  r = { ":CopilotChatReset<CR>", "Reset Chat" },
  s = { ":CopilotChatStop<CR>", "Stop Chat" },
}
vim.keymap.set("n", "<leader>p", "<Nop>", { noremap = true })
local prefix = "<leader>p"

for key, map in pairs(base_maps) do
  vim.keymap.set("n", prefix .. key, map[1], { desc = map[2] })
end
-- 创建动作映射的辅助函数
local function create_mapping(action_type, selection_type)
  return function()
    local telescope = require("CopilotChat.integrations.telescope")
    local actions = require("CopilotChat.actions")
    local select = require("CopilotChat.select")

    telescope.pick(actions[action_type] {
      selection = select[selection_type],
    })
  end
end

-- 快速聊天功能
local function quick_chat(selection_type)
  return function()
    vim.ui.input({ prompt = "Quick Chat: " }, function(input)
      if input and input ~= "" then
        local select = require("CopilotChat.select")
        require("CopilotChat").ask(input, {
          selection = select[selection_type]
        })
      end
    end)
  end
end

-- 保存聊天记录
vim.keymap.set(
  "n",
  prefix .. "S",
  function()
    vim.ui.input({ prompt = "Save Chat: " }, function(input)
      if input and input ~= "" then
        require("CopilotChat").save(input)
      end
    end)
  end,
  { desc = "Save Chat" }
)
-- 加载聊天记录

vim.keymap.set(
  "n",
  prefix .. "L",
  function()
    local copilot_chat = require("CopilotChat")
    local path = copilot_chat.config.history_path
    local scan = require("plenary.scandir").scan_dir
    local chats = scan(path, { depth = 1, hidden = true })

    for i, chat in ipairs(chats) do
      chats[i] = chat:sub(#path + 2, -6) -- 移除路径和.json扩展名
    end

    vim.ui.select(chats, { prompt = "Load Chat: " }, function(selected)
      if selected and selected ~= "" then
        copilot_chat.load(selected)
      end
    end)
  end,
  { desc = "Load Chat" }
)

-- 提示动作映射
vim.keymap.set(
  "n",
  prefix .. "p",
  create_mapping("prompt_actions", "buffer"),
  { desc = "Prompt actions" }
)
vim.keymap.set(
  "v",
  prefix .. "p",
  create_mapping("prompt_actions", "visual"),
  { desc = "Prompt actions" }
)

vim.keymap.set(
  "n",
  prefix .. "q",
  quick_chat("buffer"),
  { desc = "Quick Chat" }
)

vim.keymap.set(
  "v",
  prefix .. "q",
  quick_chat("visual"),
  { desc = "Quick Chat" }
)
-- 可视模式选中代码后提问
vim.keymap.set("v", "<leader>cf", function()
  local select = require("CopilotChat.select")
  require("CopilotChat").ask("fix this code", { selection = select["visual"] }) -- 关键在这里
end)
