#!/bin/bash -xe
docker build -t "ethdevops/swarm:$DOCKER_TAG" --target swarm .
docker build -t "ethdevops/swarm-smoke:$DOCKER_TAG" --target swarm-smoke .
docker build -t "ethdevops/swarm-global-store:$DOCKER_TAG" --target swarm-global-store .
