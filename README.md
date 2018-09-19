Since there is no Linux build available (http://daid.github.io/EmptyEpsilon/#tabs=5) and the build instructions can be bothersome (https://github.com/daid/EmptyEpsilon/wiki/Build-from-sources) if you just want a quick game.

# Requirements:

- Linux (tested on Ubuntu 18.04)
- Docker

# Setup

```
xauth nlist :0 | sed -e 's/^..../ffff/' | xauth -f /tmp/.docker.xauth nmerge -
```

# Run

```
docker run --rm -ti \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /tmp/.docker.xauth:/tmp/.docker.xauth \
  -e XAUTHORITY=/tmp/.docker.xauth \
  aequitas/empty-epsilon
```

By default it will run in non-fullscreen mode. Configuration options can be passed as arguments, eg:

```
docker run --rm -ti \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /tmp/.docker.xauth:/tmp/.docker.xauth \
  -e XAUTHORITY=/tmp/.docker.xauth \
  aequitas/empty-epsilon fullscreen=1
```
