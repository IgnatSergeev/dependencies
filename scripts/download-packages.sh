#!/bin/bash

cd `dirname $0`/../pool/main/ukazka-backend
for package in `apt-rdepends $(cat ../../../packagesCommandNames) ncurses-bin | grep -v  "^ "`; do
  echo -e $package
  if [[ $package == "libboost-regex1.74.0-icu70" ]]; then
      package=libboost-regex1.74.0
  fi
  if [[ $package == "debconf-2.0" ]]; then
      package=debconf
  fi
  if [[ $package == "perl:any" ]]; then
        package=perl
  fi
  if [[ "$(find . -type f -name $package"_*.deb")" == "" ]]; then
    apt-get download $package
    package_file_name=$(find . -type f -name $package"_*.deb")
    ar x $package_file_name
    if [[ $(find -type f -name "control.tar.zst") != "" && $(find -type f -name "control.tar.xz") == "" ]]; then
      unzstd control.tar.zst
      rm -f control.tar.zst
      xz control.tar
      rm -f control.tar
    fi
    if [[ $(find -type f -name "data.tar.zst") != "" && $(find -type f -name "data.tar.xz") == "" ]]; then
      unzstd data.tar.zst
      rm -f data.tar.zst
      xz data.tar
      rm -f data.tar
    fi

    rm $package_file_name
    ar cr $package_file_name debian-binary control.tar.xz data.tar.xz
    rm -f control.tar.xz
    rm -f data.tar.xz
    rm -f debian-binary
  fi
done