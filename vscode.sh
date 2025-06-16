# backup configuration of vscode
DIR=$( dirname "$(readlink -f  ${BASH_SOURCE[0]})" )
mkdir -p ${DIR}/vscode/configuration
cp -rvf ${HOME}/.vscode ${DIR}/vscode/configuration
