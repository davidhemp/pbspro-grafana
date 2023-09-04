#!/bin/bash

#Check Python 3 is installed
if [[ "$(python -V 2>/dev/null)" =~ "Python 3" ]] ; then
  PYTHON=python
elif [[ "$(python3 -V 2>/dev/null)" =~ "Python 3" ]] ; then
  PYTHON=python3
else
  echo "Python 3 not found"
  exit 1
fi

#Load Python venv and local variables
. venv/bin/activate
. run_env

$PYTHON main.py
