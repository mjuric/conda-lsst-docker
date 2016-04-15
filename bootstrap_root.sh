#!/bin/bash -ex

# Get git so we can clone conda-lsst
yum install -y curl
curl -O https://dl.fedoraproject.org/pub/epel/epel-release-latest-5.noarch.rpm
rpm -ivh epel-release-latest-5.noarch.rpm
yum install -y git

# get toolchain prerequisites
yum install -y \
	make glibc-headers glibc-devel patch bzip2 libgfortran bzip2-devel \
	flex bison which ncurses-devel zlib-devel which \
	libXext libSM libXrender \ # for matplotlib
	readline-devel \ # for freedts

# Add the 'build' user
useradd build
