import glob
import re
import shutil
import subprocess
import os

from setuptools import setup, Extension
import setuptools.command.build_py

UTM_VERSION = '0.12.0'
PACKAGE_NAME = 'tmEventSetup'
PACKAGE_DIR = os.path.realpath(os.path.join(os.path.dirname(__file__), PACKAGE_NAME))

UTM_BASE = os.environ.get('UTM_BASE')
if not UTM_BASE:
    raise RuntimeError("UTM_BASE not defined")

BOOST_BASE = os.environ.get('BOOST_BASE', "")
XERCES_C_BASE = os.environ.get('XERCES_C_BASE', "")

class BuildPyCommand(setuptools.command.build_py.build_py):
    """Custom build command."""

    def copy_package_data(self):
        xsd_dir = os.path.join(PACKAGE_DIR, 'xsd')
        xsd_type_dir = os.path.join(xsd_dir, 'xsd-type')
        if not os.path.exists(xsd_dir):
            os.makedirs(xsd_dir)
        if not os.path.exists(xsd_type_dir):
            os.makedirs(xsd_type_dir)
        for filename in glob.glob(os.path.join(UTM_BASE, '*.xsd')):
            shutil.copy(filename, xsd_dir)
        for filename in glob.glob(os.path.join(UTM_BASE, 'xsd-type', '*.xsd')):
            shutil.copy(filename, xsd_type_dir)

    def create_swig_wrapper(self):
        command = []
        subprocess.check_call([
            'swig',
            '-c++',
            '-python',
            '-outcurrentdir',
            '-I{}'.format(os.path.join(BOOST_BASE, 'include')),
            '-I{}'.format(os.path.join(XERCES_C_BASE, 'include')),
            '-I{}'.format(os.path.join(UTM_BASE, 'include')),
            '{}.i'.format(PACKAGE_NAME),
        ])

    def create_version_module(self):
        with open('version.py', 'w') as f:
            f.write("__version__ = '{}'".format(UTM_VERSION))
            f.write(os.linesep)
        os.chdir(cwd)

    def run(self):
        self.copy_package_data()
        self.create_swig_wrapper()
        self.create_version_module()
        # run actual build command
        setuptools.command.build_py.build_py.run(self)

tmEventSetup_ext = Extension(
    name='_tmEventSetup',
    define_macros=[('SWIG', '1'), ('DNDEBUG', '1')],
    sources=[
        os.path.join('tmEventSetup', 'tmEventSetup_wrap.cxx')
    ],
    include_dirs=[
        os.path.join(BOOST_BASE, 'include'),
        os.path.join(XERCES_C_BASE, 'include'),
        os.path.join(UTM_BASE, 'include'),
    ],
    library_dirs=[
        os.path.join(BOOST_BASE, 'lib'),
        os.path.join(XERCES_C_BASE, 'lib'),
        os.path.join(UTM_BASE, 'lib'),
    ],
    libraries=['tmutil', 'tmtable', 'tmgrammar', 'tmeventsetup'],
    extra_compile_args=['-std=c++11', '-02']
)

setup(
    name='tm-eventsetup',
    version=UTM_VERSION,
    author="Bernhard Arnold",
    author_email="bernhard.arnold@cern.ch",
    description="""Python bindings for tmEventSetup""",
    ext_modules=[tmEventSetup_ext],
    cmdclass={
        'build_py': BuildPyCommand,
    },
    packages=[PACKAGE_NAME],
    package_data={
        PACKAGE_NAME: [
            os.path.join('xsd', '*.xsd'),
            os.path.join('xsd', 'xsd-type', '*.xsd'),
            '*.i',
        ]
    },
    license="GPLv3"
)
