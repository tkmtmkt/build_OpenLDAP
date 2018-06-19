#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source $SCRIPT_DIR/build-common.sh

TARGET=db-18.1.25

# download
ARCHIVE=$ARCHIVES_DIR/$TARGET.tar.gz
DOWNLOAD_URL=http://download.oracle.com/berkeley-db/$TARGET.tar.gz
[[ ! -s $ARCHIVE ]] && curl -ksSL -o $ARCHIVE $DOWNLOAD_URL

# build
pushd $BUILD_DIR
[[ -d $TARGET ]] && rm -rf $TARGET
tar xzf $ARCHIVE

pushd $TARGET/build_unix
../dist/configure --prefix=$PREFIX \
                  --enable-compat185 \
                  --enable-dbm \
                  --enable-cxx &&
make &&
make install
RESULT=$?
popd

popd

exit $RESULT
