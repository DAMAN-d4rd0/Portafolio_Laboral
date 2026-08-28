#!/bin/bash
# Detener la ejecución si ocurre cualquier error durante el proceso
set -e
set -x

#pip3 install --no-cache-dir -r requirements.txt

echo "Iniciando la configuración de Apache Zeppelin..."
URL="https://dlcdn.apache.org/zeppelin/zeppelin-0.12.1/zeppelin-0.12.1-bin-all.tgz"
wget "$URL"
