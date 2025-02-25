# Buoy

Buoy is simple containerized web app designed for testing load-balancing and demonstrating container concepts. It continuously calls an API endpoint to display basic system information without needing to refresh the page.

# Quickstart

To download and run the latest tag from Docker Hub, simply run:

```
docker run --rm -p 5000:5000 bcbrookman/buoy
```

Docker Compose examples with multiple replicas can be found in `examples/`.

## Building the image

Alternatively, you can build the container locally.

1. Clone the repo
2. `cd` into the repo
3. Run `docker build -t buoy .`

## Licenses

 - [MIT Project License](./LICENSE)
 - [Third-party Licenses](./LICENSE_THIRD-PARTY)
