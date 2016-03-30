#!/bin/bash
git clone --branch 1.x https://github.com/driskell/log-courier /src/log-courier
cd /src/log-courier
make
export FIX_VERSION=$(bin/log-courier -version|sed s/-/./g)
make gem

PREFIX=/opt/log-courier
fpm -s dir -t deb -n log-courier -v $FIX_VERSION \
  --description "A lightweight log shipper with Logstash integration" \
  --url "https://github.com/driskell/log-courier" \
  --force \
  bin/log-courier=$PREFIX/bin/ \
  bin/lc-tlscert=$PREFIX/bin/ \
  bin/lc-admin=$PREFIX/bin/ \
  /src/log-courier.ubuntu.init=/etc/init.d/log-courier \
  docs=$PREFIX \
  lib/logstash=$PREFIX/lib \
  log-courier-$FIX_VERSION.gem=$PREFIX/lib/

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
