#!/bin/bash

# Detener el script si ocurre un error
set -e
set -x

# Configuración de variables
ZEPPELIN_TARGET_DIR="/home/vscode/zeppelin"
DOWNLOAD_ZEPPELIN="/workspaces/Portafolio_Laboral"
NOMBRE_ARCHIVO="zeppelin-0.12.1-bin-all"
ARCHIVO="zeppelin-0.12.1-bin-all.tgz"
tar -xvf "$DOWNLOAD_ZEPPELIN/$ARCHIVO"
mv "$DOWNLOAD_ZEPPELIN/$ARCHIVO" "$ZEPPELIN_TARGET_DIR"
rm -rf "$ARCHIVO"

piython -m venv "$ZEPPELIN_TARGET_DIR/virtual"  pip install --no-cache-dir -r "$DOWNLOAD_ZEPPELIN/requirements.txt"

source "$ZEPPELIN_TARGET_DIR/bin/activate"