#!/bin/sh

cd media_build && \
    ./build_all.sh ../linux_media/ -dt && \
    ./create_dkms_tar.sh && \
    mv media-build-*.dkms_src.tgz ../media-build-dkms && \
    cd ..


cd media-build-dkms && \
    ./prepare_dkms_src.sh ubuntu bionic && \
   fakeroot debian/rules binary && \
   debuild -S && \
   debuild -i -us -uc -b
