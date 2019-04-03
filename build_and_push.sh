docker build -t swarm-smoke:anton --build-arg VERSION=$1 --target swarm-smoke .
docker build -t swarm:anton --build-arg VERSION=$1 --target swarm .
docker tag swarm-smoke:anton nonsens3/swarm-smoke:anton
docker tag swarm:anton nonsens3/swarm:anton
docker push nonsens3/swarm-smoke:anton
docker push nonsens3/swarm:anton
