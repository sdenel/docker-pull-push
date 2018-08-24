[![Build Status](https://travis-ci.com/sdenel/docker-pull.svg?branch=master)](https://travis-ci.com/sdenel/docker-pull-push)

A python script to pull images from a Docker repository without installing Docker and its daemon.

The script creates a cache directory (~/.docker-pull-layers-cache) to store layers already downloaded.

# Installation
```bash
# docker-pull
curl https://raw.githubusercontent.com/sdenel/docker-pull/master/docker-pull -o docker-pull
chmod +x docker-pull

# docker-push
curl https://raw.githubusercontent.com/sdenel/docker-pull/master/docker-push -o docker-push
chmod +x docker-push

```
# Example
```bash
./docker-pull index.docker.io/library/alpine alpine
LOADED_IMAGE_ID=`docker load < alpine | tail -n 1 | cut -d ':' -f 3`
docker run $LOADED_IMAGE_ID echo "Hello world"
```

# Ressources
* Description of the img format: https://github.com/moby/moby/blob/master/image/spec/v1.2.md
