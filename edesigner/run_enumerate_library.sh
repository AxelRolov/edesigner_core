#!/bin/bash

# Source cluster setup if required
source /etc/cluster-setup.sh  # look if this is required

# Get the current directory of the script
current=$(dirname "$0")
current=$(realpath ${current})

# Activate the virtual environment if it exists
if [ -d ${current}/../eDESIGNER_venv ]; then
  source ${current}/../eDESIGNER_venv/bin/activate
else
  echo "WARNING: venv not installed (run install.sh at the first level of the repo to install the environment)."
  echo "Using the current active environment"
fi

# Set environment variables
export EDESIGNER_FOLDER=${current}
export EDESIGNER_PARFOLDER=${current}/resources
export EDESIGNER_TEST_FOLDER=${current}/test
export EDESIGNER_PREPS=${current}/preparations
export EDESIGNER_QUERIES=${current}/queries
export DEPROTECTION_FOLDER=${current}/deprotections
export PYTHONPATH=${PYTHONPATH}:${current}
export PYTHONPATH=${PYTHONPATH}:${current}/classes
export LILLYMOL_EXECUTABLES=$(head -1 ${current}/../lillymol.path)/bin/Linux

# Echo the paths
echo "EDESIGNER_FOLDER: $EDESIGNER_FOLDER"
echo "EDESIGNER_PARFOLDER: $EDESIGNER_PARFOLDER"
echo "EDESIGNER_TEST_FOLDER: $EDESIGNER_TEST_FOLDER"
echo "EDESIGNER_PREPS: $EDESIGNER_PREPS"
echo "EDESIGNER_QUERIES: $EDESIGNER_QUERIES"
echo "DEPROTECTION_FOLDER: $DEPROTECTION_FOLDER"
echo "PYTHONPATH: $PYTHONPATH"
echo "LILLYMOL_EXECUTABLES: $LILLYMOL_EXECUTABLES"

# Check if the LillyMol executables directory exists
if [ -d ${LILLYMOL_EXECUTABLES} ]; then
  echo "using ${LILLYMOL_EXECUTABLES} as a source of LillyMol executables"
else
  echo "using GC3TK as a source of LillyMol executables"
fi

# Run the Python script
python ${current}/enumerate_library.py "$@"
