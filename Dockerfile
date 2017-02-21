FROM node:6.9.5-alpine

LABEL maintainer "We ahead <docker@weahead.se>"

ENV S6_VERSION=1.19.1.1\
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2

RUN apk --no-cache add curl git \
  && apk --no-cache add --virtual build-deps \
      gnupg \
  && cd /tmp \
  && curl -OL "https://github.com/just-containers/s6-overlay/releases/download/v${S6_VERSION}/s6-overlay-amd64.tar.gz" \
  && curl -OL "https://github.com/just-containers/s6-overlay/releases/download/v${S6_VERSION}/s6-overlay-amd64.tar.gz.sig" \
  && export GNUPGHOME="$(mktemp -d)" \
  && curl https://keybase.io/justcontainers/key.asc | gpg --import \
  && gpg --verify s6-overlay-amd64.tar.gz.sig s6-overlay-amd64.tar.gz \
  && tar -xzf /tmp/s6-overlay-amd64.tar.gz -C / \
  && rm -rf "$GNUPGHOME" /tmp/* \
  && apk del build-deps


ENV NODE_ENV=production

WORKDIR /app

COPY root /

RUN npm install -s -g nodemon && npm cache clean

EXPOSE 3000

ENTRYPOINT ["/init"]

ONBUILD COPY app/package.json /app/

ONBUILD RUN npm install --dev -s && npm cache clean

ONBUILD COPY app/ /app/

ONBUILD VOLUME /app/node_modules
