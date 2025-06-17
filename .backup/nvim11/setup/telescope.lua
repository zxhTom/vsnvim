return function()
  -- 确保依赖工具已安装
  if vim.fn.executable('rg') == 0 then
    vim.notify('请先安装 ripgrep (brew install ripgrep)', vim.log.levels.WARN)
  end
end
