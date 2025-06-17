DIR=$( dirname "$(readlink -f  ${BASH_SOURCE[0]})" )
if [[ $# -lt 2 ]]
then
  echo "arguments invalid , please give me two"
  exit
fi
nvimname=$1
target=$2
cp -rvf  ${DIR}/.backup/${nvimname}/* ${HOME}/.config/${target}/
