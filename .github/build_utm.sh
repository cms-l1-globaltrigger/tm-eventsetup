UTM_VERSION=0.12.0
BOOST_DIST=$(pwd)/dist/boost
XERCES_C_DIST=$(pwd)/dist/xerces-c
UTM_DIST=$(pwd)/dist/utm
mkdir -p build
cd build
curl -OL https://gitlab.cern.ch/cms-l1t-utm/utm/-/archive/utm_${UTM_VERSION}/utm-utm_${UTM_VERSION}.tar.gz
tar xzf utm-utm_${UTM_VERSION}.tar.gz
cd utm-utm_${UTM_VERSION}
./configure
make all -j4 CPPFLAGS='-DNDEBUG -DSWIG' BOOST_BASE=${BOOST_DIST} XERCES_C_BASE=${XERCES_C_DIST}
make install PREFIX=${UTM_DIST}
