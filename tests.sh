#!/usr/bin/env bash
set -e

#
# Doc tests
#
echo ">>>> Launching unit tests for docker-pull"
cp docker-pull docker-pull-tmp.py # doctest requires a .py extension
python3 -m doctest -v docker-pull-tmp.py
rm docker-pull-tmp.py
echo ""

echo ">>>> Launching unit tests for docker-push"
cp docker-push docker-push-tmp.py # doctest requires a .py extension
python3 -m doctest -v docker-push-tmp.py
rm docker-push-tmp.py
echo ""

#
# Checking that pull is working fine
#
rm -f alpine
./docker-pull index.docker.io/library/alpine:3.8 alpine

CONTENT=`tar tvf alpine | awk '{print $6}' | sort | tr '\n' ' '`
CONTENT_EXPECTED="./ ./11cd0b38bc3ceb958ffb2f9bd70be3fb317ce7d255c8a4c3f4af30e298aa1aab.json ./8e3ba11ec2a2b39ab372c60c16b421536e50e5ce64a0bc81765c2e38381bcff6/ ./8e3ba11ec2a2b39ab372c60c16b421536e50e5ce64a0bc81765c2e38381bcff6/layer.tar ./manifest.json "
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

#
# Regtest: Checking with another image
#
./docker-pull index.docker.io/sdenel/tiny-static-web-server:latest tmp-image


# Still to do:
# * check that cache works
# * Check that when accepting gzip, the response is compressed
# * check that push works