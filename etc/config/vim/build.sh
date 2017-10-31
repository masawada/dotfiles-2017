#!/bin/bash

cp $CONFIG_DIR/src/vimrc  $BUILD_DIR/vimrc
cp -r $CONFIG_DIR/src/vim $BUILD_DIR

# download vim-plug
PLUG_VIM_PATH=$BUILD_DIR/vim/autoload/plug.vim
if [ ! -e "$PLUG_VIM_PATH" ]; then
  curl -fLo $PLUG_VIM_PATH --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
