#!/bin/bash

# Detener el script si ocurre un error
# set -e
set -x


# Configuración de variables
PROJECT_DIR=$(pwd)
ZEPPELIN_TARGET_DIR="$HOME/zeppelin"
DOWNLOAD_ZEPPELIN="$PROJECT_DIR"
NOMBRE_ARCHIVO="zeppelin-0.12.1-bin-all"
ARCHIVO="zeppelin-0.12.1-bin-all.tgz"
NOTEBOOK_JUPYTER="notebook_jupyter"
NOTEBOOK_ZEPPELIN="notebook_zeppelin"
export ZEPPELIN_NOTEBOOK_DIR="$PWD/$PROJECT_DIR/notebook_zeppelin"

###======= Se descomprime el tar y realiza operaciones 
if [ ! -d "$DOWNLOAD_ZEPPELIN/$ARCHIVO" ]; then
    echo "Se descomprime el tar e instala Zeppelin" 
    tar -xvf "$DOWNLOAD_ZEPPELIN/$ARCHIVO"
    mv "$NOMBRE_ARCHIVO" "$ZEPPELIN_TARGET_DIR"
    rm -rf "$ARCHIVO"
fi
sleep 5

###================ Se cargan librerias necesario de zeppelin y jupyter
echo "Se cargan las librerias de python"
python3 -m pip install --upgrade pip
python3 -m pip install -r "$DOWNLOAD_ZEPPELIN/requirements.txt"
sleep 5
###====== Se habilita las carpeta jupyter en el area de trabajo
echo "Creacion de carpeta de jupyter"

echo "$PROJECT_DIR/$NOTEBOOK_JUPYTER"
if [ ! -d "$PROJECT_DIR/$NOTEBOOK_JUPYTER" ] ; then
    mkdir -p "$PROJECT_DIR/$NOTEBOOK_JUPYTER"
fi

###=========== Se copian unos ejemplos de jupyter
echo "Copia de ejemplos jupyter"
cp -r "$DOWNLOAD_ZEPPELIN/.config/examples" "$PROJECT_DIR/$NOTEBOOK_JUPYTER"




###=========== Se crea el espacio de trabajo para zeppelin y se copian los ejemplos
WORKSPACE_ZEPPELIN="notebook_zeppelin"
if [ ! -d "$PROJECT_DIR/$NOTEBOOK_ZEPPELIN" ]; then
    mkdir "$PROJECT_DIR/$NOTEBOOK_ZEPPELIN"
    cp -r "$ZEPPELIN_TARGET_DIR/notebook" "$PROJECT_DIR/$NOTEBOOK_ZEPPELIN"
fi

###========= Se copian los ejemplos de zeppelin
# echo "copia de ejemplos zeppelin"
# echo "$ZEPPELIN_TARGET_DIR/notebook_zeppelin"
# echo "$PROJECT_DIR/notebook_zeppelin"
# if [ ! -d "$ZEPPELIN_TARGET_DIR/nnotebook_zeppelin" ]; then
#     echo "Se copia $ZEPPELIN_TARGET_DIR/notebook_zeppelin"
#     cp -r "$ZEPPELIN_TARGET_DIR/notebook" "$PROJECT_DIR/notebook_zeppelin"
# fiW
# cp -r "$ZEPPELIN_TARGET_DIR/notebook" "$PROJECT_DIR/notebook_zeppelin"
# ###======= Se inicia el demonio zeppelin


# "$ZEPPELIN_TARGET_DIR/bin/zeppelin-daemon.sh" start
# "$ZEPPELIN_TARGET_DIR/bin/zeppelin-daemon.sh" restart
echo "$PROJECT_DIR/$NOTEBOOK_JUPYTER  --invocar al mero"
sleep 5
nohup jupyter notebook --NotebookApp.token='' --NotebookApp.password='' --notebook-dir="$PROJECT_DIR/$NOTEBOOK_JUPYTER" > /home/vscode/jupyter.log 2>&1 &
sleep 5

# jupyter notebook --NotebookApp.token='' --NotebookApp.password='' --notebook-dir='notebook_jupyter' > /home/vscode/jupyter.log 2>&1 &
# jupyter notebook stop 8888
# /home/vscode/zeppelin/bin/zeppelin-daemon.sh start