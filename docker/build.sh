#!/bin/bash
SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE:-$0});pwd)

TARGET=openldap

case "$1" in
  centos6|ubuntu1404)
    pushd ${SCRIPT_DIR}
    docker-compose run --rm $1 /opt/${TARGET}/workspace/scripts/build-all.sh
    RESULT=$?
    popd
    exit ${RESULT}
    ;;
  *)
    echo "Usage: $0 [centos6|ubuntu1404]"
    ;;
esac
