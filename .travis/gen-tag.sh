#!/bin/bash -xe
export DOCKER_TAG="$TRAVIS_BRANCH"
if [ "$TRAVIS_BRANCH" == "master" ]; then
  export DOCKER_TAG="latest"
fi
if [[ -n "$TRAVIS_TAG" ]] ; then
  export DOCKER_TAG="$TRAVIS_TAG"
fi
