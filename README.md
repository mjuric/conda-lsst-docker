# Build a CentOS 5 docker container to build conda LSST binaries

## Image

To build the image that has conda-lsst and everything set up, run:

```
docker build -t conda-lsst-docker conda-lsst-docker
```

(where `conda-lsst-docker` is this repository).

## Rebuilds

To run the rebuild within the container, run (for example):

```
conda-lsst-docker()
{
	docker run -it -v $PWD/builds:/builds --rm conda-lsst-docker conda lsst "$@"
}

mkdir builds
conda-lsst-docker make-recipes build:b2002 lsst_apps lsst_sims --build
```

This will build the recipes and the packages in `$PWD/build` directory.

Note: You'll want to keep the `build` directory between builds, so that
packages aren't unnecessarily rebuilt.
