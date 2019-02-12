#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
$DIR/build.sh -n

docker run -d mmerian/docker-tor:latest
docker ps|grep 'mmerian/docker-tor:latest'
exit $?
