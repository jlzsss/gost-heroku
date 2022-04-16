FROM alpine:latest

ENV VER=2.11.2 METHOD=chacha20 PASSWORD=ss123456
ENV TLS_PORT=4433 PORT=8080

RUN apk add --no-cache curl \
  && curl -sL https://github.com/jlzsss/gost-heroku/releases/download/v${VER}/gost-linux-amd64-${VER}.tar.gz | tar zx  \
  && mv gost-linux-amd64-${VER} gost && chmod a+x /gost/gost

WORKDIR /gost
EXPOSE ${TLS_PORT} $PORT

CMD exec /gost/gost -L=ss+mwss://$METHOD:$PASSWORD@:$TLS_PORT -L=ss+mws://$METHOD:$PASSWORD@:$PORT

