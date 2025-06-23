local M={}
M.get_os = function()
  -- Neovim 专用判断方式
  if vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 then
    return 'windows'
  elseif vim.fn.has('mac') == 1 or vim.fn.has('macunix') == 1 then
    return 'macos'
  else
    return 'linux'
  end
end
return M
