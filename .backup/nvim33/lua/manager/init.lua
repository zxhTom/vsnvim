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
 spec = {
    {
      import = "plugins"
    },
  },
  install = {
    colorscheme = {
      "kanagawa"
    }
  },
  checker = {
    enabled = true,
  } 
})
