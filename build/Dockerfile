FROM golang:1.11-alpine as builder

ARG VERSION=9dc5d1a91

RUN apk add --update git gcc g++ linux-headers
RUN mkdir -p $GOPATH/src/github.com/ethereum && \
    cd $GOPATH/src/github.com/ethereum && \
    git clone https://github.com/ethersphere/go-ethereum && \
    cd $GOPATH/src/github.com/ethereum/go-ethereum && \
    git checkout ${VERSION} && \
    go get github.com/ethereum/go-ethereum && \
    go get . && go get ./cmd/geth && go get ./cmd/swarm && go get ./cmd/swarm/swarm-smoke && \
    cd $GOPATH/src/github.com/ethereum/go-ethereum && \
    go install -ldflags "-X main.gitCommit=${VERSION}" ./cmd/swarm && \
    go install -ldflags "-X main.gitCommit=${VERSION}" ./cmd/geth && \
    go install -ldflags "-X main.gitCommit=${VERSION}" ./cmd/swarm/swarm-smoke && \
    go install -ldflags "-X main.gitCommit=${VERSION}" ./cmd/swarm/global-store
