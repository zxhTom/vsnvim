local os = require'utils.system'.get_os()
-- 禁用 netrw（使用 Telescope 的文件浏览器替代）
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
if os == 'windows' then
  vim.opt.clipboard='unamed'
else
  vim.opt.clipboard='unnamedplus'
end
