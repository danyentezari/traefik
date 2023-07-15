Reference: ChatGPT

docker swarm init
docker stack deploy -c docker-compose.yaml jupyter-suite
docker service ps jupyter-suite_jupyter

docker swarm leave --force

docker service inspect --format='{{range .Endpoint.Ports}}{{.PublishedPort}}{{end}}' jupyter-suite_jupyter




Reference: https://docs.docker.com/engine/swarm/ingress/

docker service create \
  --name jupyter-service \
  --publish published=8888,target=8887 \
  --replicas 2 \
  code_docker_jupyter_image