# Build a CentOS 5 docker container to build conda LSST binaries

## To build the image
docker build -t cdock conda-lsst-docker

## To run the rebuild
docker run -it -e TERM -v $PWD/builds:/builds --rm cdock \
#	conda lsst make-recipes build:b2002 wcslib --build
	conda lsst make-recipes build:b2002 galsim --build
