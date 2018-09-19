# [Empty Epsilon](http://daid.github.io/EmptyEpsilon/) for Linux as Docker container.

Since there is no Linux build available (http://daid.github.io/EmptyEpsilon/#tabs=5) and the build instructions can be bothersome (https://github.com/daid/EmptyEpsilon/wiki/Build-from-sources) if you just want a quick game.

## Requirements:

- Linux (tested on Ubuntu 18.04)
- X11
- Docker

## Run

```
docker run --rm -ti \
  -v $HOME/.Xauthority:/root/.Xauthority \
  --network=host \
  aequitas/empty-epsilon
```

By default it will run in non-fullscreen mode. Configuration options can be passed as arguments, eg:

```
docker run --rm -ti \
  -v $HOME/.Xauthority:/root/.Xauthority \
  --network=host \
  aequitas/empty-epsilon fullscreen=1
```
