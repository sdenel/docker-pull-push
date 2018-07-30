#!/usr/bin/env bash
set -e

# TODO: does not work with gcr.io/distroless/cc@sha256:923564f1d33ac659c15edf538b62f716ed436d7cc5f6a9d64460b8affba9ccd9 !

rm -f alpine
./docker-pull index.docker.io/library/alpine alpine
DOCKER_LOADING=`docker load < alpine`
echo $DOCKER_LOADING
LOADED_IMAGE_ID=`echo $DOCKER_LOADING | tail -n 1 | cut -d ':' -f 3`
OUTPUT=`docker run $LOADED_IMAGE_ID echo "Hello world"`
if [[ "$OUTPUT" != "Hello world" ]]
then
  echo "$OUTPUT is not equal to \"Hello, world\""
fi
