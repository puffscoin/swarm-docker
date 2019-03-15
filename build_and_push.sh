docker build -t swarm-smoke:anton --target swarm-smoke .
docker build -t swarm:anton --target swarm .
docker tag swarm-smoke:anton ethdevops/swarm-smoke:anton
docker tag swarm:anton ethdevops/swarm:anton
docker push ethdevops/swarm-smoke:anton
docker push ethdevops/swarm:anton
