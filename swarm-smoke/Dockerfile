FROM alpine:3.8
WORKDIR /
COPY --from=swarm-local:build /go/bin/swarm-smoke /
ADD run-smoke.sh /run-smoke.sh
ENTRYPOINT ["/run-smoke.sh"]
