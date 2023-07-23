# Steps for Setting Up Traefik

1. Download tar
https://github.com/traefik/traefik/releases
curl -LOJ https://github.com/traefik/traefik/releases/download/v2.10.3/traefik_v2.10.3_darwin_arm64.tar.gz


2. Install Traefik
tar -zxvf ./traefik_v2.10.3_darwin_amd64.tar.gz


<!-- 3. Run traefic.yml
docker run -d -p 8080:8080 -p 80:80 \
    -v $PWD/traefik.yml:/etc/traefik/traefik.yml traefik:v2.10 -->

4. Create traefic network
docker network create traefik-network

<!-- 5. Run traefik (dashboard)
./traefik --configFile=traefik.toml -->

6. Run docker-compose.yml
docker-compose up

7. Open the dashboard
http://localhost:8080/dashboard/#/http/routers

7b. Create and run container for image (this will be done from Flask)
docker run -d \
  --name cdj-2 \
  --label "traefik.enable=true" \
  --label "traefik.http.routers.cdj-2.rule=Host(\`cdj-2.localhost\`)" \
  --label "traefik.http.routers.cdj.entrypoints=web" \
  --network traefik-network \
  code_docker_jupyter_image

7c. Only create container for image (this will be done from Flask)

docker create \
  --name cdj-62701d4250ac436de2c2c7b1 \
  --label "traefik.enable=true" \
  --label "traefik.http.routers.cdj-62701d4250ac436de2c2c7b1.rule=Host(\`cdj-62701d4250ac436de2c2c7b1.localhost\`)" \
  --label "traefik.http.routers.cdj.entrypoints=web" \
  --network traefik-network \
  code_docker_jupyter_image


docker create \
  --name cdj-abc \
  --label "traefik.enable=true" \
  --label "traefik.http.routers.cdj-abc.rule=Host(\`cdj-abc.bignumber.online\`)" \
  --label "traefik.http.routers.cdj.entrypoints=web" \
  --network traefik-network \
  code_docker_jupyter_image


  - "traefik.enable=true"
  - "traefik.http.routers.your_container.rule=Host(`cdj-abc.domain.com`)"
  - "traefik.http.routers.your_container.entrypoints=web" 
  - "traefik.http.routers.your_container.service=your_container"
  - "traefik.http.services.your_container.loadbalancer.server.port=80"

# Other

Stop docker containers from restarting
docker update --restart=no $(docker ps -a -q)
  

Stop all containers
docker stop $(docker ps -q)




