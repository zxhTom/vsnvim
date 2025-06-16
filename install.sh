nvim_path=$1
chard_version=$2
if [[ -z $chard_version ]]
then
  version=$($nvim_path --version | grep -oP '(?<=v\d.)\d+(?=\.)' | grep -vE '^$')
else
  version=${chard_version}
fi
DIR=$( dirname "$(readlink -f  ${BASH_SOURCE[0]})" )
nvimname=nvim${version}
nvim_path=$(readlink -f "$nvim_path")
nvim_bin=$(dirname ${nvim_path})
nvim_root=$(dirname ${nvim_bin})
echo "Version:"${version}
rm -rf ${HOME}/.config/${nvimname}
rm -rf ${HOME}/.local/share/${nvimname}
rm -rf ${HOME}/.local/state/${nvimname}
rm -rf ${HOME}/.cache/${nvimname}
sh ${DIR}/struct.sh ${nvimname}
cat ${HOME}/.zshrc | grep '\.zxhtom/neovimprofile' | grep 'source' 1>/dev/null
if [[ $? -eq 1 ]]
then
  echo "not exist , i will install profile"
  echo "source ~/.zxhtom/neovimprofile">>~/.zshrc
fi
if [[ ! -f ${HOME}/.zxhtom/neovimprofile ]]
then
  touch ${HOME}/.zxhtom/neovimprofile
fi
cat ${HOME}/.zxhtom/neovimprofile | grep 'alias '"${nvimname}"'="NVIM_APPNAME='"${nvimname}"' VIMRUNTIME='"${nvim_root}"'/share/nvim/runtime '"${nvim_path}"'"'
if [[ $? -eq 1 ]]
then
  echo "not exist , i will add neovim to path"
  echo "alias ${nvimname}=\"NVIM_APPNAME=${nvimname} VIMRUNTIME=${nvim_root}/share/nvim/runtime ${nvim_path}\"">>~/.zxhtom/neovimprofile
fi
# 配置目录
mkdir -p ~/.config/${nvimname}/lua/plugins

# 数据目录（插件、缓存等）
mkdir -p ~/.local/share/${nvimname}
# 3. 创建插件配置文件
cat > ~/.config/${nvimname}/lua/options.lua <<EOF
-- 禁用 netrw（使用 Telescope 的文件浏览器替代）
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
EOF
cat > ~/.config/${nvimname}/lua/aftoptions.lua <<EOF
-- 限制运行时路径
vim.opt.rtp:append('${HOME}/.vscode/extensions/asvetliakov.vscode-neovim-1.18.22/runtime/')
EOF
cat > ~/.config/${nvimname}/lua/plugins/setup/telescope.lua <<EOF
return function()
  -- 确保依赖工具已安装
  if vim.fn.executable('rg') == 0 then
    vim.notify('请先安装 ripgrep (brew install ripgrep)', vim.log.levels.WARN)
  end
end
EOF
cat > ~/.config/${nvimname}/lua/keyboards/telescope.lua <<EOF
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
EOF
cat > ~/.config/${nvimname}/lua/config/telescope.lua <<EOF
local telescope = require('telescope')
telescope.setup({
  defaults = {
    file_ignore_patterns = { "node_modules" }
  }
})
EOF
cat > ~/.config/${nvimname}/lua/plugins/init.lua <<EOF
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
      'nvim-lua/plenary.nvim', 
      'nvim-telescope/telescope-fzf-native.nvim' -- 可选：高性能排序
    },
    config = function()
      require('plugins.setup.telescope')()  -- 先检查依赖
      require('config.telescope')          -- 再加载配置
      require('keyboards.telescope')          -- 再加载配置
    end
  }
})
EOF
# 示例：创建一个最小化配置
echo '
require("options")
-- ~/.config/'"${nvimname}"'/init.lua
require("plugins/init")
require("aftoptions")
' > ~/.config/${nvimname}/init.lua
# NVIM_APPNAME=nvim${version} /path/to/new_nvim/bin/nvim
mkdir -p ${DIR}/.bins
cp ${DIR}/nvimtemplate ${DIR}/.bins/${nvimname}
sed -i 's/\(NVIM_APPNAME\)=".*"/\1="'"${nvimname}"'"/g' ${DIR}/.bins/${nvimname}
sed -i 's@\(VIMRUNTIME\)=".*"@\1="'"${nvim_root}"'/share/nvim/runtime"@g' ${DIR}/.bins/${nvimname}
sed -i 's@.*\(NVIM_BIN\)=.*@\1="'"${nvim_path}"'"@g' ${DIR}/.bins/${nvimname}
ln -sf ${DIR}/.bins/${nvimname} ~/.local/bin/${nvimname}
