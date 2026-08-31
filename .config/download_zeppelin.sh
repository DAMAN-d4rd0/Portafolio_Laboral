#!/bin/bash

# Detener el script si ocurre un error
set -e
# set -x
VERDE='\033[0;32m'
SIN_COLOR='\033[0m'

# Configuración de variables
PROJECT_DIR=$(pwd)
ZEPPELIN_TARGET_DIR="$HOME/zeppelin"
DOWNLOAD_ZEPPELIN="$PROJECT_DIR"
NOMBRE_ARCHIVO="zeppelin-0.12.1-bin-all"
ARCHIVO="zeppelin-0.12.1-bin-all.tgz"
NOTEBOOK_JUPYTER="notebook_jupyter"
NOTEBOOK_ZEPPELIN="notebook_zeppelin"
export ZEPPELIN_NOTEBOOK_DIR="$PWD/$PROJECT_DIR/notebook_zeppelin"



# ======== creacion de carpeta download
HOME_DOWNLOAD="download"
if [ ! -d "$HOME/$HOME_DOWNLOAD" ]; then
    mkdir -p $HOME/$HOME_DOWNLOAD
    printf "%-60s [  ${VERDE}OK${SIN_COLOR}  ]\n" "directorio $HOME/$HOME_DOWNLOAD correctamente"
fi

###======= Se descomprime el tar y realiza operaciones 
if [ ! -d "$DOWNLOAD_ZEPPELIN/$ARCHIVO" ]; then
    printf "%-60s [  ${VERDE}WAIT....${SIN_COLOR}  ]\n" "Zeppelin install in $ZEPPELIN_TARGET_DIR"
    tar -xvf "$DOWNLOAD_ZEPPELIN/$ARCHIVO"
    mv "$NOMBRE_ARCHIVO" "$ZEPPELIN_TARGET_DIR"
    cp -r "$ARCHIVO" "$HOME/download"
    rm -rf "$ARCHIVO"
    printf "%-60s [  ${VERDE}OK${SIN_COLOR}  ]\n" "Zeppelin instalado en $ZEPPELIN_TARGET_DIR"
    sleep 3
    if [ -d "$DOWNLOAD_ZEPPELIN/.config/config/shiro.ini" ]; then
        cp -r "$DOWNLOAD_ZEPPELIN/.config/config/shiro.ini" "$ZEPPELIN_TARGET_DIR/conf"
        printf "%-60s [  ${VERDE}OK${SIN_COLOR}  ]\n" "Seguridad SHIRO para Zeppelin instalado en $ZEPPELIN_TARGET_DIR"
    fi
    if [ -d "$DOWNLOAD_ZEPPELIN/.config/config/zeppelin-site.xml" ]; then
        cp -r "$DOWNLOAD_ZEPPELIN/.config/config/shiro.ini" "$ZEPPELIN_TARGET_DIR/conf"
        printf "%-60s [  ${VERDE}OK${SIN_COLOR}  ]\n" "Configuración para Zeppelin instalado en $ZEPPELIN_TARGET_DIR"
    fi
    if [ -d "$DOWNLOAD_ZEPPELIN/.config/config/zeppelin-sh.xml" ]; then
        cp -r "$DOWNLOAD_ZEPPELIN/.config/config/shiro.ini" "$ZEPPELIN_TARGET_DIR/conf"
        printf "%-60s [  ${VERDE}OK${SIN_COLOR}  ]\n" "Variables para Zeppelin instalado en $ZEPPELIN_TARGET_DIR"
    fi
fi
sleep 5

###================ Se cargan librerias necesario de zeppelin y jupyter
echo "Se cargan las librerias de python"
python3 -m pip install --upgrade pip
python3 -m pip install -r "$DOWNLOAD_ZEPPELIN/requirements.txt"
sleep 5

JUPYTER_DIR="jupyter"

echo "$HOME/$JUPYTER_DIR"
if [ ! -d "$HOME/JUPYTER_DIR" ]; then
    # echo "$HOME/$JUPYTER_DIR"
    mkdir -p "$HOME/$JUPYTER_DIR"
    cp -r "$DOWNLOAD_ZEPPELIN/.config/jupyter-daemon.sh" "$HOME/$JUPYTER_DIR"
    printf "%-60s [  ${VERDE}OK${SIN_COLOR}  ]\n" "Jupyter Notebook instalado"
fi
###============= Creacion de carpetas de home
# mkdir -p "$PROJECT_DIR/$NOTEBOOK_JUPYTER"


###====== Se habilita las carpeta jupyter en el area de trabajo



echo "Creacion de carpeta de jupyter"

echo "$PROJECT_DIR/$NOTEBOOK_JUPYTER  <<<<<<<<<<<< < crear carpeta"
if [ ! -d "$PROJECT_DIR/$NOTEBOOK_JUPYTER" ] ; then
    mkdir -p "$PROJECT_DIR/$NOTEBOOK_JUPYTER"
    cp -r "$DOWNLOAD_ZEPPELIN/.config/examples" "$PROJECT_DIR/$NOTEBOOK_JUPYTER"
    printf "%-60s [  ${VERDE}OK${SIN_COLOR}  ]\n" "Configuracion del espacio de Jupyter"
fi

###=========== Se crea el espacio de trabajo para zeppelin y se copian los ejemplos
WORKSPACE_ZEPPELIN="notebook_zeppelin"
if [ ! -d "$PROJECT_DIR/$NOTEBOOK_ZEPPELIN" ]; then
    mkdir "$PROJECT_DIR/$NOTEBOOK_ZEPPELIN"
    cp -r "$ZEPPELIN_TARGET_DIR/notebook" "$PROJECT_DIR/$NOTEBOOK_ZEPPELIN"
    printf "%-60s [  ${VERDE}OK${SIN_COLOR}  ]\n" "Configuracion del espacio de Zeppelin"
fi

# "$ZEPPELIN_TARGET_DIR/bin/zeppelin-daemon.sh" start
# "$ZEPPELIN_TARGET_DIR/bin/zeppelin-daemon.sh" restart
# echo "$PROJECT_DIR/$NOTEBOOK_JUPYTER  --invocar al mero"
# sleep 5
# nohup jupyter notebook --NotebookApp.token='' --NotebookApp.password='' --notebook-dir="$PROJECT_DIR/$NOTEBOOK_JUPYTER" > /home/vscode/jupyter/jupyter.log 2>&1 &
sleep 5

# jupyter notebook --NotebookApp.token='' --NotebookApp.password='' --notebook-dir='notebook_jupyter' > /home/vscode/jupyter/jupyter.log 2>&1 &

# jupyter notebook --NotebookApp.token='' --NotebookApp.password='' --notebook-dir='notebook_jupyter' > /home/vscode/jupyter.log 2>&1 &
# jupyter notebook stop 8888
# /home/vscode/zeppelin/bin/zeppelin-daemon.sh start