#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0);pwd)
BASE_DIR=$(cd $SCRIPT_DIR/..;pwd)

export LANG=C
export PREFIX=$(cd $BASE_DIR/..;pwd)
export PREFIX_BUILDTOOL=$PREFIX/buildtool
export PATH=$PREFIX_BUILDTOOL/bin:$PREFIX/bin:$PATH
#export PKG_CONFIG=$PREFIX_BUILDTOOL/bin/pkg-config
export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
export CFLAGS="-I$PREFIX/include"
export CPPFLAGS="-I$PREFIX/include"
export LDFLAGS="-L$PREFIX/lib -Wl,-rpath,$PREFIX/lib"
export LT_SYS_LIBRARY_PATH=$PREFIX/lib
export LD_LIBRARY_PATH=$PREFIX/lib
export MANPATH=$PREFIX/man:

export ARCHIVES_DIR=$BASE_DIR/archives
[[ ! -d $ARCHIVES_DIR ]] && mkdir -p $ARCHIVES_DIR

export BUILD_DIR=$BASE_DIR/build
[[ ! -d $BUILD_DIR ]] && mkdir -p $BUILD_DIR