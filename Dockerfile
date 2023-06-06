FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

ARG MONERO_ARCH
ARG MONERO_VERSION
ARG MONERO_SHA256

RUN apt-get -qq update && apt-get -qq install --yes curl bzip2

WORKDIR /root

RUN curl -fsSL https://downloads.getmonero.org/cli/monero-linux-$MONERO_ARCH-v$MONERO_VERSION.tar.bz2 -O && \
  echo "$MONERO_SHA256  monero-linux-$MONERO_ARCH-v$MONERO_VERSION.tar.bz2" | sha256sum -c - && \
  tar -xf monero-linux-$MONERO_ARCH-v$MONERO_VERSION.tar.bz2 --directory /root --strip 1

FROM ubuntu:latest

ARG APPLICATION_NAME=monero-full-node
ARG BUILD_VERSION=1.0
ARG BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ')

ENV DEBIAN_FRONTEND=noninteractive

LABEL org.label-schema.name="f4bio/monero-full-node"
LABEL org.label-schema.description="docker image to run a monero full network node"
LABEL org.label-schema.url="https://github.com/f4bio/monero-full-node"
LABEL org.label-schema.application=$APPLICATION_NAME
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.version=$BUILD_VERSION
LABEL org.opencontainers.image.source="https://github.com/f4bio/monero-full-node"

RUN useradd -ms /bin/bash monero && mkdir -p /home/monero/.bitmonero && chown -R monero:monero /home/monero/.bitmonero
USER monero
WORKDIR /home/monero

COPY --chown=monero:monero --from=0 /root/monerod /opt/bin/

# blockchain location
VOLUME /home/monero/.bitmonero

EXPOSE 18080 18081

ENTRYPOINT ["/opt/bin/monerod"]
CMD ["--non-interactive", "--restricted-rpc", "--rpc-bind-ip=0.0.0.0", "--confirm-external-bind", "--enable-dns-blocklist", "--out-peers=16"]
