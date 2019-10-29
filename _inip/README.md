# INIP fork of Verdaccio

## git

```bash
git remote add upstream git@github.com:verdaccio/verdaccio.git

git remote -v

git fetch upstream

# try rebase...
git rebase upstream/master
```

## Docker

### Create Docker Volume and copy files

```bash
docker volume rm verdaccio
docker voluem list
docker volume create verdaccio

docker rm -f verdaccio;
V_PATH=/home/docker-user/verdaccio; docker run -d --name verdaccio \
    -e "VERDACCIO_PORT=8443" \
    -e "VERDACCIO_PROTOCOL=https" \
    -e "XDG_CONFIG_HOME=/verdaccio-docker/conf" \
    -p 8443:8443 \
    --mount source=verdaccio,target=/verdaccio-docker \
    verdaccio/verdaccio sh -c "tail -f /etc/hosts"

docker cp _inip/conf verdaccio:/verdaccio-docker/conf
docker cp _inip/certs verdaccio:/verdaccio-docker/certs
docker cp _inip/storage verdaccio:/verdaccio-docker/storage
docker exec --user root verdaccio sh -c "chown -R verdaccio: /verdaccio-docker"

# to check
docker exec -it --user root verdaccio sh
```

### Run

```bash
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
```

NPM repo will now be at: <https://npm.inip.dev:8443/>

### Access running verdaccio container

```bash
docker exec -it --user root verdaccio sh

./_inip/start.sh
```

### Update Config on running container

```bash
docker cp _inip/conf/config.yaml verdaccio:/verdaccio/conf/config.yaml
```

then restart via `./_inip/start.sh`

## htpasswd

generate a new password

```bash
htpasswd -m inip
```

Then copy that into /verdaccio/conf/htpasswd

## NPM token

_Note: As of Verdaccio 4.3.4 this appears broken. Do not use_

```bash
npm login
npm token list --registry https://npm.inip.dev:8443/
```
