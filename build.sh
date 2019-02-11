#!/bin/sh
set -o errexit

TAG=${TAG:-latest}

# Build base image
docker build -t swarm-local:build build

# Build release images
docker build -t "ethdevops/swarm:${TAG}" swarm
docker build -t "ethdevops/swarm-globalstore:${TAG}" swarm-globalstore
docker build -t "ethdevops/swarm-smoke:${TAG}" swarm-smoke
