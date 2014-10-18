#!/bin/bash
git clone https://github.com/driskell/log-courier /src/log-courier
cd /src/log-courier
make
make gem

VERSION=$(bin/log-courier -version|grep -o '[0-9\.]*')
PREFIX=/opt/log-courier
fpm -s dir -t deb -n log-courier -v $VERSION \
  --description "A lightweight log shipper with Logstash integration" \
  --url "https://github.com/driskell/log-courier" \
  --force \
  bin/log-courier=$PREFIX/bin/ \
  bin/lc-tlscert=$PREFIX/bin/ \
  bin/lc-admin=$PREFIX/bin/ \
  /src/log-courier.ubuntu.init=/etc/init.d/log-courier \
  docs=$PREFIX \
  lib/logstash=$PREFIX/lib \
  log-courier-$VERSION.gem=$PREFIX/lib/

if mountpoint -q /target; then
    echo
    echo "Copying the finished deb package to /target"
    cp -v *.deb /target
else
    echo
    echo "/target is not a mountpoint."
    echo "You should:"
    echo "- re-run this container with -v \$(pwd):/target"
fi