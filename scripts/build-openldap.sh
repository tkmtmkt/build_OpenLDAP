#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0);pwd)
source ${SCRIPT_DIR}/build-common.sh

TARGET=openldap-2.4.47

# download
ARCHIVE=${ARCHIVES_DIR}/${TARGET}.tgz
DOWNLOAD_URL=https://www.openldap.org/software/download/OpenLDAP/openldap-release/${TARGET}.tgz
[[ ! -s ${ARCHIVE} ]] && curl -ksSL -o ${ARCHIVE} ${DOWNLOAD_URL}

# build
pushd ${BUILD_DIR}
[[ -d ${TARGET} ]] && rm -rf ${TARGET}
tar xf ${ARCHIVE}

pushd ${TARGET}
./configure --prefix=${PREFIX} &&
make &&
make install
RESULT=$?
popd

popd

exit ${RESULT}
