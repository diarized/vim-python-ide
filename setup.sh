#!/bin/bash

# Please activate node.js before running the script:
# nvm use --lts
#
set -eu

SOURCE_DIR=$(dirname $BASH_SOURCE)
cd $SOURCE_DIR


if [[ ! -d .git ]]; then
  echo "I am not in cloned repo"
  exit 1
fi

if [[ -f $HOME/vimrc ]]; then
  cat ~/.vimrc >> ~/.vimrc.backup_$$
fi
: >~/.vimrc
VIM_HOME=$HOME/.vim
VIM_INCLUDE=$VIM_HOME/include
VIMRC=$HOME/.vimrc
mkdir -p $VIM_INCLUDE

bash ./install_plug.sh
#bash ./install_solarized_flattened.sh

function install_include {
  cp $1 $VIM_INCLUDE
  echo "source $1" >>$VIMRC
}

install_include vimspector_pre.vimrc
install_include plugins.vimrc
install_include splits.vimrc
install_include folding.vimrc
install_include oddsnends.vimrc
install_include nerdtree.vimrc
# install_include ale.vimrc
install_include indent.vimrc
# LIght color scheme
# install_include everforest.vimrc
install_include coc.vimrc
install_include colorscheme.vimrc
# install_include black.vimrc
install_include slime.vimrc
install_include pydocstring.vimrc
install_include vimspector.vimrc
vim -c 'PlugInstall | qall'
vim -c 'CocInstall coc-pyright coc-json coc-html'
