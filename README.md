# Build a CentOS 5 docker container to build conda LSST binaries

## Image

To build the image that has conda-lsst and everything set up, run:

```
docker build -t cdock conda-lsst-docker
```

(where `conda-lsst-docker` is this repository).

## Rebuilds

To run the rebuild within the container, run (for example)

```
docker run -it -e TERM -v $PWD/builds:/builds --rm cdock \
	conda lsst make-recipes build:b2002 lsst_apps lsst_sims --build
```
