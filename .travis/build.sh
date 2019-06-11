#!/bin/bash -xe
docker build -t "puffsdevops/swarm:$DOCKER_TAG" --target swarm .
docker build -t "puffsdevops/swarm-smoke:$DOCKER_TAG" --target swarm-smoke .
docker build -t "puffsdevops/swarm-global-store:$DOCKER_TAG" --target swarm-global-store .
