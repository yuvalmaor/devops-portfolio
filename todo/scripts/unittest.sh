#!/bin/sh
set -e
pwd

ls
#need to run unit tests on monolit
cd app
. venv/bin/activate
pytest test.py

# Deactivate the virtual environment
deactivate