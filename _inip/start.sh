#!/bin/bash

docker cp _inip/conf/config.yaml verdaccio:/verdaccio-docker/conf/config.yaml
docker rm -f verdaccio;

V_PATH=/home/docker-user/verdaccio; docker run -d --name verdaccio \
    -e "VERDACCIO_PORT=8443" \
    -e "VERDACCIO_PROTOCOL=https" \
    -e "XDG_CONFIG_HOME=/verdaccio-docker/conf" \
    -p 8443:8443 \
    --mount source=verdaccio,target=/verdaccio-docker \
    verdaccio/verdaccio \
    sh -c "/opt/verdaccio/bin/verdaccio --config /verdaccio-docker/conf/config.yaml --listen https://0.0.0.0:8443"

docker logs -f verdaccio;
