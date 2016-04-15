#!/bin/bash -ex

CONDA_LSST_BRANCH=improve-deps

# install conda build
git clone https://github.com/mjuric/conda-lsst
cd conda-lsst
git checkout $CONDA_LSST_BRANCH
./bin/bootstrap.sh

# Change the recipes directory
sed -i 's|^output_dir:.*|output_dir: /builds/recipes|' "$HOME"/conda-lsst/etc/config.yaml

# Fix up the conda-build bug du jour.
sed -i 's|assert "conda-bld/git_cache" in cache_dir|pass|' "$HOME"/conda-lsst/miniconda/lib/python2.7/site-packages/conda_build/environ.py

# Fix up the conda bug du jour.
sed -i 's|if ms and name != ms.name:|if ms and name != name.split()[0]:|' "$HOME"/conda-lsst/miniconda/lib/python2.7/site-packages/conda/cli/main_search.py

# Add paths and some useful utilities to .bashrc
cat >> ~/.bashrc <<-"EOT"
	# Add to path
	export PATH="$HOME/conda-lsst/bin:$HOME/conda-lsst/miniconda/bin:$PATH"

	# Some useful utilities
	rebuild() { bash /builds/recipes/rebuild.sh; }
	log()     { cat  /builds/recipes/$1/_build.log; }
EOT

# Define conda channels and the build directory
cat > ~/.condarc <<-EOF
conda-build:
  root-dir: /builds/packages
  
channels:
  - http://research.majuric.org/conda/null
  - defaults
EOF
