FROM elixir:alpine

ARG APP_NAME=trendinghashtaggraph
ARG PHOENIX_SUBDIR=apps/web

ENV PORT=8080
ENV REPLACE_OS_VARS=true
ENV MIX_ENV=prod

WORKDIR /opt/app

RUN apk add --update alpine-sdk
RUN apk update && apk --no-cache --update add bash openssl-dev
RUN apk update \
    && apk --no-cache --update add git nodejs nodejs-npm \
    && mix local.rebar --force \
    && mix local.hex --force

COPY . .

RUN mix do deps.get, deps.compile, compile
RUN cd ${PHOENIX_SUBDIR} \
    && npm install \
    && ./node_modules/brunch/bin/brunch build -p \
    && mix phoenix.digest
RUN mix release --env=prod --verbose \
    && mv _build/prod/rel/${APP_NAME} /opt/release \
    && mv /opt/release/bin/${APP_NAME} /opt/release/bin/start_server

EXPOSE ${PORT}
CMD ["/opt/release/bin/start_server", "foreground"]
