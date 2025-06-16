DIR=$( dirname "$(readlink -f  ${BASH_SOURCE[0]})" )
nvimname=$1
cp -rvf  ${DIR}/.backup/${nvimname} ${HOME}/.config/
