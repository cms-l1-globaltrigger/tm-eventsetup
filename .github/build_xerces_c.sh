XERCES_C_VERSION=3.2.5
XERCES_C_DIST=$(pwd)/dist/xerces-c
mkdir -p build
cd build
curl -OL https://dlcdn.apache.org//xerces/c/3/sources/xerces-c-${XERCES_C_VERSION}.tar.gz
tar xzf xerces-c-${XERCES_C_VERSION}.tar.gz
cd xerces-c-${XERCES_C_VERSION}
./configure
make -j4
make install prefix=${XERCES_C_DIST}
