DIR=$( dirname "$(readlink -f  ${BASH_SOURCE[0]})" )
if [[ $# -lt 2 ]]
then
  echo "arguments invalid , please give me two"
  exit
fi
nvimname=$1
target=$2
mkdir -p ${DIR}/.backup/${target}
cp -rvf ${HOME}/.config/${nvimname}/lua ${DIR}/.backup/${target}
