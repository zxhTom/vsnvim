DIR=$( dirname "$(readlink -f  ${BASH_SOURCE[0]})" )
nvimname=$1
mkdir -p ${DIR}/.backup/${nvimname}
cp -rvf ${HOME}/.config/${nvimname}/lua ${DIR}/.backup/${nvimname}
