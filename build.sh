#!/bin/bash

BUILD_OPTIONS=''
TAG_VERSION='no'
PUSH_TAG='no'

while getopts "ntp" option; do
    case $option in
        n)
            BUILD_OPTIONS='--no-cache'
        ;;
        t)
            TAG_VERSION='yes'
        ;;
        p)
            PUSH_TAG='yes'
        ;;
    esac
done

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
docker build $DIR -t mmerian/docker-tor:latest $BUILD_OPTIONS

if [ "$TAG_VERSION" == "yes" ]; then
    # Get tor version number, in order to create tag
    TOR_VER=`docker run mmerian/docker-tor:latest tor --version`
    TOR_VER=${TOR_VER/'Tor version '/''}
    TOR_VER=${TOR_VER/%./''}
    echo "Tagging version $TOR_VER"
    docker tag mmerian/docker-tor:latest mmerian/docker-tor:$TOR_VER
    if [ "$PUSH_TAG" == "yes" ]; then
        echo "Pushing tag latest"
        docker push "mmerian/docker-tor:latest"
        echo "Pushing tag $TOR_VER"
        docker push "mmerian/docker-tor:$TOR_VER"
    fi
fi
