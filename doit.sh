#!/bin/sh -e

COMMIT=$(git describe --always)

cd media_build

# prepare linux_media tarball
./build_all.sh ../linux_media/ -dt

# prepare media_build tarball for dkms
# includes linux_media tarball
./create_dkms_tar.sh

# move media_build tarball to dkms builder
mv media-build-*.dkms_src.tgz ../media-build-dkms

cd ../media-build-dkms

# extract media_build tarball
./prepare_dkms_src.sh Ubuntu bionic

dch -i Used commit: https://github.com/ali1234/tbs-dkms/tree/$COMMIT

# create a binary package
fakeroot debian/rules binary

# create the source package and sign it
debuild -S

# create the binary package
debuild -i -b

cat debian/changelog
