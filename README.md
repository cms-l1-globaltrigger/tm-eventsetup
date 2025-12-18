# tm-eventsetup

Python bindings for tmEventSetup.

## Install

It is recommended to install the utm Python bindings in a virtual environment
which makes it also possible to use multiple versions in parallel.

```bash
pip install --index https://globaltrigger.web.cern.ch/pypi tm-eventsetup==0.14.0
```

## Build instructions

**Note:** building the Python bindings from scratch is only recommended for
development. To create portable Python bindings use the
[tm-manylinux](https://github.com/cms-l1-globaltrigger/tm-manylinux)
Docker image.

Make sure to install all required build dependecies.

On ubuntu based distributions install
```bash
sudo apt-get install git build-essential libboost-dev libboost-system-dev libboost-filesystem-dev libxerces-c-dev python3-dev python3-venv swig
```

Check out and build all utm libraries.

**Important:** compile using the `-DSWIG` flag, see below.

```bash
git clone https://gitlab.cern.ch/cms-l1t-utm/utm.git -b utm_0.14.0
cd utm
./configure
make all -j4 CPPFLAGS='-DNDEBUG -DSWIG'  # compile with -DSWIG
make install PREFIX=dist
export UTM_BASE=$(pwd)/dist
cd ..
```

Next build the Python bindings and install the resulting wheel. It is
recommended to execute this step in a virtual environment.

```bash
git clone https://github.com/cms-l1-globaltrigger/tm-eventsetup.git -b 0.14.0
cd tm-eventsetup
python3 -m venv env
. env/bin/activate
pip install --upgrade pip
pip install .
```
