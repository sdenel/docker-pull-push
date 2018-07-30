#!/usr/bin/env bash
set -e

# TODO: does not work with gcr.io/distroless/cc@sha256:923564f1d33ac659c15edf538b62f716ed436d7cc5f6a9d64460b8affba9ccd9 !

rm -f alpine
./docker-pull index.docker.io/library/alpine:3.8 alpine

CONTENT=`tar tvf alpine | awk '{print $6}' | tr '\n' ' '`
CONTENT_EXPECTED="./ ./manifest.json ./8e3ba11ec2a2b39ab372c60c16b421536e50e5ce64a0bc81765c2e38381bcff6/ ./8e3ba11ec2a2b39ab372c60c16b421536e50e5ce64a0bc81765c2e38381bcff6/layer.tar ./11cd0b38bc3ceb958ffb2f9bd70be3fb317ce7d255c8a4c3f4af30e298aa1aab.json "
if [[ "$CONTENT" != "$CONTENT_EXPECTED" ]]
then
  echo "CONTENT is not equal to CONTENT_EXPECTED:"
  echo "$CONTENT"
  echo "$CONTENT_EXPECTED"
  exit 1
fi

DOCKER_LOADING=`docker load < alpine`
echo $DOCKER_LOADING
LOADED_IMAGE_ID=`echo $DOCKER_LOADING | tail -n 1 | cut -d ':' -f 3`
OUTPUT=`docker run $LOADED_IMAGE_ID echo "Hello world"`
if [[ "$OUTPUT" != "Hello world" ]]
then
  echo "$OUTPUT is not equal to \"Hello, world\""
  exit 1
fi
