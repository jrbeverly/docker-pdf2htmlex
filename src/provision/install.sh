#!/bin/sh
set -ex
cd /tmp/

apk --no-cache add --virtual build-dependencies libxml2 libxml2-dev alpine-sdk xz poppler-dev pango-dev m4 libtool perl autoconf automake coreutils python-dev zlib-dev freetype-dev glib-dev cmake

# fontforge
cd /tmp/
mkdir fontforge && cd fontforge
curl -sSL ${FONTFORGE_URL} | tar xfz - -C . --strip-components=1
./bootstrap --force
./configure --without-iconv
make
make install

# pdf2htmlEX
cd /tmp/
mkdir pdf2htmlex && cd pdf2htmlex
curl -sSL ${PDF2HTMLEX_URL} | tar xfz - -C . --strip-components=1
cmake . && make && make install

apk del build-dependencies
rm -rf /tmp/* /var/tmp/* /var/cache/apk/*