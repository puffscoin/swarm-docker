FROM golang:1.11-alpine as builder

ARG VERSION=update1.8

RUN apk add --update git gcc g++ linux-headers
RUN mkdir -p $GOPATH/src/github.com/ethereum && \
    cd $GOPATH/src/github.com/ethereum && \
    git clone https://github.com/holiman/go-ethereum && \
    cd $GOPATH/src/github.com/ethereum/go-ethereum && \
    git checkout ${VERSION} && \
    go install -ldflags "-X main.gitCommit=${VERSION}" ./cmd/swarm && \
    go install -ldflags "-X main.gitCommit=${VERSION}" ./cmd/geth && \
    go install -ldflags "-X main.gitCommit=${VERSION}" ./cmd/swarm/swarm-smoke


FROM alpine:3.8 as swarm-smoke
WORKDIR /
COPY --from=builder /go/bin/swarm-smoke /
ADD run-smoke.sh /run-smoke.sh
ENTRYPOINT ["/run-smoke.sh"]

FROM alpine:3.8 as swarm
WORKDIR /
COPY --from=builder /go/bin/swarm /go/bin/geth /
ADD run.sh /run.sh
ENTRYPOINT ["/run.sh"]
