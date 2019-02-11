FROM alpine:3.8
WORKDIR /
COPY --from=swarm-local:build /go/bin/swarm /go/bin/geth /
ADD run.sh /run.sh
ENTRYPOINT ["/run.sh"]
