FROM node:6.2.1

MAINTAINER We ahead <docker@weahead.se>

RUN useradd --user-group --create-home --shell /bin/false app

ENV HOME=/home/app \
    NODE_ENV=production

WORKDIR /app

RUN npm install -s -g nodemon && npm cache clean

EXPOSE 3000

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

ONBUILD COPY app/package.json /app/

ONBUILD RUN chown -R app:app /app

ONBUILD USER app

ONBUILD RUN npm install --dev -s && npm cache clean

ONBUILD USER root

ONBUILD COPY app/ /app/

ONBUILD RUN chown -R app:app /app

ONBUILD USER app

ONBUILD VOLUME /app/node_modules
