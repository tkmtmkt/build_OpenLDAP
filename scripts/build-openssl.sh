#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source $SCRIPT_DIR/build-common.sh

TARGET=OpenSSL_1_1_0h

# download
ARCHIVE=$ARCHIVES_DIR/$TARGET.tar.gz
DOWNLOAD_URL=https://github.com/openssl/openssl/archive/$TARGET.tar.gz
[[ ! -s $ARCHIVE ]] && curl -ksSL -o $ARCHIVE $DOWNLOAD_URL

# build
pushd $BUILD_DIR
[[ -d $TARGET ]] && rm -rf $TARGET
tar zxf $ARCHIVE

#PERL=$PREFIX/bin/perl

pushd openssl-$TARGET
./config zlib \
         --prefix=$PREFIX \
         --openssldir=$PREFIX/ssl \
         --with-zlib-include=$PREFIX/include \
         --with-zlib-lib=$PREFIX/lib \
         -Wl,-rpath,$PREFIX/lib &&
make &&
make install_sw &&
make install_ssldirs &&
make install_man_docs
RESULT=$?
popd

popd

exit $RESULT