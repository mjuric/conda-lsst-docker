FROM    centos:centos5

# Following instructions on:
# https://www.digitalocean.com/community/tutorials/docker-explained-using-dockerfiles-to-automate-building-of-images

ADD    bootstrap_root.sh  /
ADD    bootstrap_build.sh /

RUN    /bootstrap_root.sh

USER    500
WORKDIR /home/build

RUN    /bootstrap_build.sh

ENV    PATH /home/build/conda-lsst/bin:/home/build/conda-lsst/miniconda/bin:$PATH

#USER    0
