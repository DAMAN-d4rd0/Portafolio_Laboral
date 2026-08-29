#!/bin/bash
# Detener la ejecución si ocurre cualquier error durante el proceso
# set -e
set -x
PROJECT_DIR=$(pwd)
NOTEBOOK_ZEPPELIN="notebook_zeppelin"
PATH_ZEPPELIN="zeppelin"

##====================Seteo de variables globales en el contenedor
#Se configura el espacio  del trabajo en github o en el lucal de acuerdo a la invocacion
if ! grep -q "export WORKSPACE=$PROJECT_DIR" ~/.bashrc; then
    echo "export WORKSPACE=$PROJECT_DIR" >> ~/.bashrc
fi

#se configura la ruta del almacen del trabajo en zeppelin en el espacio de trabajo
if ! grep -q "export ZEPPELIN_NOTEBOOK_DIR=$PROJECT_DIR/$NOTEBOOK_ZEPPELIN" ~/.bashrc; then
    echo "export ZEPPELIN_NOTEBOOK_DIR=$PROJECT_DIR/$NOTEBOOK_ZEPPELIN" >> ~/.bashrc
fi

#se configura la ruta del almacen del trabajo en zeppelin en el espacio de trabajo
if ! grep -q "export ZEPPELIN_INSTALL_DIR=$HOME/$PATH_ZEPPELIN" ~/.bashrc; then
    echo "export ZEPPELIN_INSTALL_DIR=$HOME/$PATH_ZEPPELIN" >> ~/.bashrc
fi
 
##===================Seteo de variables del documentos
ZEPPELIN_INSTALL_DIR="$HOME/$PATH_ZEPPELIN"

echo "la ruta del usuario vscode $HOME"
echo "la ruta del proyecto $PROJECT_DIR"
echo "la ruta de la instalacion de zeppelin $ZEPPELIN_INSTALL_DIR"

if [ ! -d "$ZEPPELIN_INSTALL_DIR" ]; then
    echo "Iniciando la descarga de Apache Zeppelin..."
    URL="https://dlcdn.apache.org/zeppelin/zeppelin-0.12.1/zeppelin-0.12.1-bin-all.tgz"
    wget "$URL"
fi
