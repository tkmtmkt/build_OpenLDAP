#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source $SCRIPT_DIR/build-common.sh

# OpenSSL 1.1.0 support was added in upcoming 2.1.27 release
#TARGET=cyrus-sasl-2.1.26
TARGET=cyrus-sasl-2.1.27

# download
ARCHIVE=$ARCHIVES_DIR/$TARGET.tar.gz
#DOWNLOAD_URL=ftp://ftp.cyrusimap.org/cyrus-sasl/$TARGET.tar.gz
DOWNLOAD_URL=ftp://ftp.cyrusimap.org/cyrus-sasl/$TARGET-rc8.tar.gz
[[ ! -s $ARCHIVE ]] && curl -ksSL -o $ARCHIVE $DOWNLOAD_URL

# build
pushd $BUILD_DIR
[[ -d $TARGET ]] && rm -rf $TARGET
tar xf $ARCHIVE

pushd $TARGET
./configure --prefix=$PREFIX \
            --sysconfdir=$PREFIX/etc \
            --enable-auth-sasldb \
            --with-dbpath=/var/lib/sasl/sasldb2 \
            --with-saslauthd=/var/run/saslauthd &&
make &&
make install
RESULT=$?
popd

popd

exit $RESULT
