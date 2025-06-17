return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "BurntSushi/ripgrep",
    "sharkdp/fd",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-project.nvim",
    "nvim-telescope/telescope-fzf-native.nvim" -- 可选：高性能排序
  },
  config = function()
    require('setup.telescope')() -- 先检查依赖
    require('config.telescope') -- 再加载配置
    require('keyboards.telescope') -- 再加载配置
  end
}
