#!/bin/bash

source "$LIB_DIR/util.sh";

if is_macos; then
  cat $CONFIG_DIR/src/tmux.conf{,.mac} > $BUILD_DIR/tmux.conf
else
  cp $CONFIG_DIR/src/tmux.conf $BUILD_DIR/tmux.conf
fi
