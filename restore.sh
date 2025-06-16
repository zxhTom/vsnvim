DIR=$( dirname "$(readlink -f  ${BASH_SOURCE[0]})" )
nvimname=$1
mkdir -p ${HOME}/.backup/${nvimname}
cp -rvf  ${HOME}/.backup/${nvimname} ${HOME}/.config/
