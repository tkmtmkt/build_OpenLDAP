#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source $SCRIPT_DIR/build-common.sh

# require 4.4 or later, but less than 6.0.20
TARGET=db-5.3.28

# download
ARCHIVE=$ARCHIVES_DIR/$TARGET.tar.gz
DOWNLOAD_URL=http://download.oracle.com/berkeley-db/$TARGET.tar.gz
[[ ! -s $ARCHIVE ]] && curl -ksSL -o $ARCHIVE $DOWNLOAD_URL

# build
pushd $BUILD_DIR
[[ -d $TARGET ]] && rm -rf $TARGET
tar xf $ARCHIVE

pushd $TARGET/build_unix
../dist/configure --prefix=$PREFIX \
                  --disable-replication \
                  --enable-compat185 \
                  --enable-cxx \
                  --enable-dbm &&
make &&
make install
RESULT=$?
popd

popd

exit $RESULT
