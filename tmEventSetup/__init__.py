import sys, os

UTM_XSD_DIR = os.path.join(os.path.dirname(__file__), 'xsd')
os.environ.setdefault('UTM_XSD_DIR', UTM_XSD_DIR)

from .tmEventSetup import *

from .version import __version__

