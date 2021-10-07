# Buoy

Buoy is simple containerized web app designed for testing load-balancing and demonstrating container concepts. It continuously calls an API endpoint to display basic system information without needing to refresh the page.

# Quickstart

To download and run the latest tag from Docker Hub, simply run:

```
docker run -d -p 5000:5000 bcbrookman/buoy
```

A more complex example using multiple replicas and a container load-balancer like the one below can be run with `docker stack deploy` or `docker-compose --compatibility up -d`

```
---
version: "3.3"

services:
  traefik:
    image: "traefik:v2.5"
    container_name: "traefik"
    command:
      - "--log.level=DEBUG"
      - "--api.insecure=true"
      - "--providers.docker=true"
      - "--providers.docker.exposedbydefault=false"
      - "--entrypoints.web.address=:80"
    ports:
      - "8000:80"
      - "8080:8080"
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock:ro"

  buoy:
    image: "bcbrookman/buoy"
    deploy:
      replicas: 3
    labels:
      - "traefik.enable=true"
      - "traefik.http.services.buoy.loadbalancer.server.port=5000"
      - "traefik.http.routers.buoy.rule=PathPrefix(`/`)"
      - "traefik.http.routers.buoy.entrypoints=web"
      - "traefik.http.routers.buoy.service=buoy"
```

This docker-compose file can also be found in `examples/`

## Building the image

Alternatively, you can build the container locally.

1. Clone the repo
2. `cd` into the repo
3. Run `docker build -t buoy .`

## Licenses

 - [MIT Project License](./LICENSE)
 - [Third-party Licenses](./LICENSE_THIRD-PARTY)