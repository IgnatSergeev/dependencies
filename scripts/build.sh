#!/bin/bash

cd `dirname $0`/..
apt-ftparchive --arch amd64 packages pool/main > dists/stable/main/binary-amd64/Packages
gzip -k dists/stable/main/binary-amd64/Packages
apt-ftparchive contents pool/main > dists/stable/main/Contents-amd64
gzip -k dists/stable/main/Contents-amd64
apt-ftparchive -c=release.conf release dists/stable/ > dists/stable/Release
gpg -a --yes --output dists/stable/Release.gpg --local-user $1 --detach-sign dists/stable/Release
gpg -a --yes --clear-sign --output dists/stable/InRelease --local-user $1 --detach-sign dists/stable/Release
find . -type f -exec sudo chmod a+r {} \;
find . -type d -exec sudo chmod a+rx {} \;