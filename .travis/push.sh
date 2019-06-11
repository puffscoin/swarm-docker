#!/bin/bash -e
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker push "puffsdevops/swarm:$DOCKER_TAG"
docker push "puffsdevops/swarm-smoke:$DOCKER_TAG"
docker push "puffsdevops/swarm-global-store:$DOCKER_TAG"
