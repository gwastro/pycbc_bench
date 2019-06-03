#!/usr/local/bin/python

import imp
import os
from astropy.utils import iers

iers.conf.auto_download = False
def which(pgm):
    path=os.getenv('PATH')
    for p in path.split(os.path.pathsep):
        p=os.path.join(p,pgm)
        if os.path.exists(p) and os.access(p,os.X_OK):
            return p
imp.load_source('pycbc_inference', which('pycbc_inference'))
