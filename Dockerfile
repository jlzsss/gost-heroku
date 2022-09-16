FROM alpine:latest

ENV VER=3.0.0-beta.5 METHOD=aes-256-cfb PASSWORD=jlz13565852287
ENV TLS_PORT=4433 PORT=8080
WORKDIR /usr/local/bin/

RUN apk add --no-cache curl \
  && curl -sL https://github.com/go-gost/gost/releases/download/v${VER}/gost-linux-amd64-${VER}.gz
  && gzip -d gost-linux-amd64-${VER}.gz
  && mv gost-linux-amd64-${VER} gost && chmod a+x /usr/local/bin/gost

EXPOSE ${TLS_PORT} $PORT

CMD exec /usr/local/bin/gost -L=ss+mwss://$METHOD:$PASSWORD@:$TLS_PORT -L=ss+mws://$METHOD:$PASSWORD@:$PORT

