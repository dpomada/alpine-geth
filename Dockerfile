FROM alpine:latest
MAINTAINER Chance Hudson

EXPOSE 8545

RUN apk add --no-cache --virtual .build-deps git make go alpine-sdk linux-headers && \
  git clone https://github.com/ethereum/go-ethereum.git && \
  cd go-ethereum && \
  make geth && \
  mv ./build/bin/geth /usr/bin/geth && \
  apk del .build-deps && \
  cd .. && \
  rm -rf go-ethereum

CMD ["/usr/bin/geth", "--fast", "--cache=256", "--rpc", "--rpcaddr", "0.0.0.0"]
