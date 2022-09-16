FROM alpine:latest

ENV VER=3.0.0-beta.5 METHOD=aes-256-cfb PASSWORD=jlz13565852287
ENV TLS_PORT=4433 PORT=8080
WORKDIR /gost

RUN apk add --no-cache curl \
  && curl -sL https://github.com/jlzsss/gost-heroku/releases/download/v${VER}/gost-linux-amd64-${VER}.gz | tar zx \
  && mv gost-linux-amd64 gost && chmod a+x gost/gost

EXPOSE ${TLS_PORT} $PORT

CMD exec /gost/gost -L=ss+mwss://$METHOD:$PASSWORD@:$TLS_PORT -L=ss+mws://$METHOD:$PASSWORD@:$PORT

