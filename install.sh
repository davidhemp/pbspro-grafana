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
echo "Found $($PYTHON -V)"

#Check pip is installed
$PYTHON -m ensurepip --upgrade --user
$PYTHON -m pip install --upgrade --user pip 
if [[ "$($PYTHON -m pip --version 2>/dev/null)" =~ "pip 2" ]]; then
  PIP=pip
elif [[ "$($PYTHON -m pip3 --version 2>/dev/null)" =~ "pip 2" ]]; then
  PIP=pip3
else
  echo "pip module not found and failed to install"
  exit 1
fi

$PYTHON -m $PIP --version

#Check virtualenv is installed
$PYTHON -m $PIP install virtualenv --user
if [[ "$?" != "0" ]]; then
  echo "Installation of virtualenv failed"
  exit 1
fi

$PYTHON -m virtualenv venv
source venv/bin/activate
$PYTHON -m $PIP install influxdb_client
