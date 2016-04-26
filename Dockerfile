FROM dylanfoster/alpine:3.3

ENV DOCKER_VERSION 1.7.0

RUN apk add --no-cache curl \
      && curl -fsSl "https://get.docker.com/builds/Linux/x86_64/docker-${DOCKER_VERSION}.tgz" \
      -o "docker-${DOCKER_VERSION}.tgz" \
      && tar zxvf "docker-${DOCKER_VERSION}.tgz" \
      && rm "docker-${DOCKER_VERSION}.tgz" \
      && apk del curl
