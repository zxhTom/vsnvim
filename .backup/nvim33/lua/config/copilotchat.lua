require("CopilotChat").setup(
  {
    suggestion = {
      keymap = {
        accept = "<C-x>", -- 改为 Alt+l 接受建议
        accept_word = "<C-right>", -- 接受当前单词
        accept_line = "<C-down>", -- 接受当前行
      }
    }
  }
)
