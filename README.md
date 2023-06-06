# docker-monero-full-node

docker image to run a monero full network node

## multiarch build

### `arm/v7`

```bash
docker buildx build \
  --platform linux/arm/v7 \
  --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
  --build-arg APPLICATION_NAME=monero-full-node \
  --build-arg BUILD_VERSION=1.0 \
  --build-arg MONERO_ARCH=armv7 \
  --build-arg MONERO_VERSION=0.18.2.2 \
  --build-arg MONERO_SHA256=11b70a9965e3749970531baaa6c9d636b631d8b0a0256ee23a8e519f13b4b300 \
  --file Dockerfile \
  --tag f4bio/monero-full-node:latest \
  --push \
  --no-cache \
  .
```

### `arm/v8`

```bash
docker buildx build \
  --platform linux/arm/v9 \
  --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
  --build-arg APPLICATION_NAME=monero-full-node \
  --build-arg BUILD_VERSION=1.0 \
  --build-arg MONERO_ARCH=armv9 \
  --build-arg MONERO_VERSION=0.18.2.2 \
  --build-arg MONERO_SHA256=f3867f2865cb98ab1d18f30adfd9168f397bd07bf7c36550dfe3a2a11fc789ba \
  --file Dockerfile \
  --tag f4bio/monero-full-node:latest \
  --push \
  --no-cache \
  .
```

## normal build

```bash
docker build \
  --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
  --build-arg APPLICATION_NAME=monero-full-node \
  --build-arg BUILD_VERSION=1.0 \
  --file Dockerfile \
  --tag f4bio/monero-full-node:latest \
  --push \
  .
```
