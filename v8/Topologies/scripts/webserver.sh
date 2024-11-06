#!/bin/sh

apk update
apk add python3 py3-pip

mkdir /app
cd /app

python3 -m venv /app

source /app/bin/activate

pip3 install flask

cp /scripts/webserver/app.py ./

python3 /app/app.py &