#!/bin/bash

source "$LIB_DIR/util.sh";

cp $CONFIG_DIR/src/gitignore $BUILD_DIR/gitignore

if is_macos; then
  cat $CONFIG_DIR/src/gitconfig{,.mac} > $BUILD_DIR/gitconfig
else
  cp $CONFIG_DIR/src/gitconfig $BUILD_DIR/gitconfig
fi
