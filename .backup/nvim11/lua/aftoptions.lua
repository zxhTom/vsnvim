-- 限制运行时路径
local path_to_add = vim.fn.expand("~") .. "/.vscode/extensions/asvetliakov.vscode-neovim-1.18.22/runtime/"
if not vim.tbl_contains(vim.opt.rtp:get(), path_to_add) then
  vim.opt.rtp:append(path_to_add)
end
