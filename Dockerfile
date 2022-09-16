FROM alpine:3.6

ENV VER=3.0.0-beta.5 METHOD=aes-256-cfb PASSWORD=jlz13565852287
ENV TLS_PORT=4433 PORT=8080

RUN apk add --no-cache curl \
  && curl -sL https://github.com/go-gost/gost/releases/download/v${VER}/gost-linux-amd64-${VER}.gz | gzip -dq \
  && mv gost/gost-linux-amd64 gost/gost && chmod a+x gost/gost

WORKDIR /gost
EXPOSE ${TLS_PORT} $PORT

CMD exec /gost/gost -L=ss+mwss://$METHOD:$PASSWORD@:$TLS_PORT -L=ss+mws://$METHOD:$PASSWORD@:$PORT

