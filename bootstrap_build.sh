#!/bin/bash -ex

# install conda build
git clone https://github.com/mjuric/conda-lsst
cd conda-lsst
./bin/bootstrap.sh

# Fix up the conda-build bug
sed -i 's|assert "conda-bld/git_cache" in cache_dir|pass|' /home/build/conda-lsst/miniconda/lib/python2.7/site-packages/conda_build/environ.py

# Fix up the conda bug
sed -i 's|if ms and name != ms.name:|if ms and name != name.split()[0]:|' /home/build/conda-lsst/miniconda/lib/python2.7/site-packages/conda/cli/main_search.py

echo 'export PATH="$HOME/conda-lsst/bin:$HOME/conda-lsst/miniconda/bin:$PATH"' >> ~/.bashrc

cat > ~/.condarc <<-EOF
conda-build:
  root-dir: /builds
  
channels:
  - http://research.majuric.org/conda/null
  - defaults
EOF

#export PATH="$PWD/bin:$PWD/miniconda/bin:$PATH"
#conda lsst make-recipes build:b2002 wcslib
#bash /home/build/conda-lsst/recipes/rebuild.sh
