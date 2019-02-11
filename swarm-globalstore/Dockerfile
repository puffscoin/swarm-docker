FROM alpine:3.8
WORKDIR /
COPY --from=swarm-local:build /go/bin/global-store /
ENTRYPOINT ["/global-store"]
