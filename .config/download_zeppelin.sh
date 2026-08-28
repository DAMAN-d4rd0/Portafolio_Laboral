#!/bin/bash

# Detener el script si ocurre un error
set -e
set -x
# Configuración de variables
ZEPPELIN_TARGET_DIR="/home/vscode/zeppelin"
DOWNLOAD_ZEPPELIN="/workspaces/Portafolio_Laboral"
ARCHIVO="zeppelin-0.12.1-bin-all.tgz"
 if [ ! -d "$ZEPPELIN_TARGET_DIR" ]; then
    tar -xvf "$DOWNLOAD_ZEPPELIN/$ARCHIVO" -C "$ZEPPELIN_TARGET_DIR"
    rm -rf "$ARCHIVO"
   # /home/vscode/zeppelin/bin/zeppelin-daemon.sh start
# echo "¡Proceso terminado con éxito!"
else
    echo "ℹ️ Zeppelin ya se encuentra instalado en $ZEPPELIN_TARGET_DIR Omitiendo descarga."
    rm -rf "$ARCHIVO"
fi