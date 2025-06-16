-- 设置插件路径
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- 如果没安装，会自动 clone
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 安装插件列表
require("lazy").setup({
  {
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
      require('plugins.setup.telescope')() -- 先检查依赖
      require('config.telescope') -- 再加载配置
      require('keyboards.telescope') -- 再加载配置
    end
  }
})
