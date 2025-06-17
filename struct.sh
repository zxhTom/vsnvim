# /Users/zxhtom/.config/nvim_default
# ├── init.lua
# └── lua
#     ├── config
#     ├── core
#     │   ├── autocmds.lua
#     │   ├── keymaps.lua
#     │   └── options.lua
#     └── plugins
#         ├── init.lua
#         └── setup

nvimname=$1
if [[ -z $nvimname ]]
then
  nvimname="nvim_default"
fi
mkdir -p ${HOME}/.config/${nvimname}
mkdir -p ${HOME}/.config/${nvimname}/lua
touch ${HOME}/.config/${nvimname}/init.lua

mkdir -p ${HOME}/.config/${nvimname}/lua/core
mkdir -p ${HOME}/.config/${nvimname}/lua/plugins
mkdir -p ${HOME}/.config/${nvimname}/lua/config
mkdir -p ${HOME}/.config/${nvimname}/lua/keyboards
mkdir -p ${HOME}/.config/${nvimname}/lua/setup
mkdir -p ${HOME}/.config/${nvimname}/lua/manager
mkdir -p ${HOME}/.config/${nvimname}/lua/utils

touch ${HOME}/.config/${nvimname}/lua/core/{options,autocmds,keymaps}.lua
touch ${HOME}/.config/${nvimname}/lua/utils/import.lua


# example:
# nvim_default/
# ├── init.lua                 # 主入口，加载 core 和 plugins
# └── lua/
#     ├── config/              # 插件/功能配置
#     │   ├── lsp.lua
#     │   ├── telescope.lua
#     │   └── ...
#     ├── core/                # 基础配置
#     │   ├── options.lua
#     │   ├── keymaps.lua
#     │   └── ...
#     └── plugins/
#         ├── init.lua         # 插件声明
#         └── setup/          # 大型插件的独立配置目录（可选）

# description
# lua/
# ├── config/
# │   ├── telescope.lua  # 仅运行时行为配置
# │   └── lsp.lua
# ├── plugins/
# │   ├── init.lua       # 插件声明
# │   └── setup/
# │       ├── telescope.lua  # 安装参数/依赖管理
# │       └── lsp.lua        # 服务器安装配置
