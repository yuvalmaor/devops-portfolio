#!/bin/sh
pwd #debug
ls #debug
cd app
pwd #debug
ls -la #debug
python3 -m venv venv
. venv/bin/activate
pip install -r requirements.txt
deactivate