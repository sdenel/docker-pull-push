[![Build Status](https://travis-ci.com/sdenel/docker-pull.svg?branch=master)](https://travis-ci.com/sdenel/docker-pull)

A python script to pull images from a Docker repository without installing Docker and its daemon.

The script creates a cache directory (~/.docker-pull-layers-cache) to store layers already downloaded.

# Installation
```bash
# With wget:
wget https://raw.githubusercontent.com/sdenel/docker-pull/master/docker-pull
# With curl:
curl https://raw.githubusercontent.com/sdenel/docker-pull/master/docker-pull > docker-pull

# Then:
chmod +x docker-pull
```
# Example
```bash
./docker-pull index.docker.io/library/alpine alpine
LOADED_IMAGE_ID=`docker load < alpine | tail -n 1 | cut -d ':' -f 3`
docker run $LOADED_IMAGE_ID echo "Hello world"
```

# Ressources
* Description of the img format: https://github.com/moby/moby/blob/master/image/spec/v1.2.md
