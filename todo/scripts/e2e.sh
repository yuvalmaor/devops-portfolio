#!/bin/sh
pwd
ls


docker compose up -d --build

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <param>"
    exit 1
fi

param=$1
sleep 10
code=$(curl -s -o /dev/null -w '%{http_code}' $param:8085)
echo $code
if [ "$code" -eq 200 ]; then
    echo "output is 200"
else
    echo "output error output is not 200" >&2
    code=$(curl -s -o /dev/null -w '%{http_code}' 15.207.155.57:8085)
    echo $code
    exit 1
fi