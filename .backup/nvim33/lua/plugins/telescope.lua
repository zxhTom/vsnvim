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
    require('utils.import').all('telescope')
  end
}
