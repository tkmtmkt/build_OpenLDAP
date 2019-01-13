#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0);pwd)

case "$1" in
  centos6|ubuntu1404)
    pushd $SCRIPT_DIR
    docker-compose run --rm $1 /usr/local/workspace/scripts/build-all.sh
    popd
    ;;
  *)
    echo "Usage: $0 [centos6|ubuntu1404]"
    ;;
esac
