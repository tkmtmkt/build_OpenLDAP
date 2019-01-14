#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/build-common.sh

TARGET=cyrus-sasl-2.1.27

# download
ARCHIVE=${ARCHIVES_DIR}/${TARGET}.tar.gz
DOWNLOAD_URL=https://github.com/cyrusimap/cyrus-sasl/releases/download/${TARGET}/${TARGET}.tar.gz
[[ ! -s ${ARCHIVE} ]] && curl -ksSL -o ${ARCHIVE} ${DOWNLOAD_URL}

# build
pushd ${BUILD_DIR}
[[ -d ${TARGET} ]] && rm -rf ${TARGET}
tar xf ${ARCHIVE}

pushd ${TARGET}
./configure --prefix=${PREFIX} \
            --sysconfdir=${PREFIX}/etc \
            --enable-auth-sasldb \
            --with-dbpath=/var/lib/sasl/sasldb2 \
            --with-saslauthd=/var/run/saslauthd &&
make &&
make install
RESULT=$?
popd

popd

exit ${RESULT}
