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
	docker run -it -v $PWD/builds:/builds --rm mjuric/conda-lsst-docker conda lsst "$@"
}

mkdir builds
chmod o+w builds	# This is needed if your UID is not 500 (the UID of the user within the docker container)
conda-lsst-docker make-recipes build:b2002 lsst_apps lsst_sims --build
```

This will build the recipes and the packages in `$PWD/build` directory.

Note: You'll want to keep the `build` directory between builds, so that
packages aren't unnecessarily rebuilt.

## FAQ

* Q: The command complains about `sqlalchemy.exc.OperationalError: (sqlite3.OperationalError) unable to open database file`:
  * A: You don't have permissions to write into the `builds` directory. This can happen for a few reasons:
     * You forgot to create it on the host
     * The permissions are wrong (i.e., you may need to `chmod o+w` if your `uid` on the host is not 500)
     * SELinux may be preventing docker from mounting the local directory as a volume
