#!/bin/sh

cd media_build && \
    ./build_all.sh ../linux_media/ -dt && \
    ./create_dkms_tar.sh && \
    mv media-build-*.dkms_src.tgz ../media-build-dkms



