#!/bin/bash -e
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker push "ethdevops/swarm:$DOCKER_TAG"
docker push "ethdevops/swarm-smoke:$DOCKER_TAG"
