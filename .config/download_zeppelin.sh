#!/bin/bash

# Detener el script si ocurre un error
set -e

# Configuración de variables
URL="https://dlcdn.apache.org/zeppelin/zeppelin-0.12.1/zeppelin-0.12.1-bin-all.tgz"
ARCHIVO="zeppelin-0.12.1-bin-all.tgz"
CARPETA_ORIGINAL="zeppelin-0.12.1-bin-all" # <- El nombre que ya viene dentro del tar
CARPETA_NUEVA="zeppeling"                  # <- El nombre que tú quieres
RUTA_ZEPPELING="/home/vscode"
echo "1. Descargando archivo..."
cd "$RUTA_ZEPPELING"
wget -q "$URL"

echo "2. Descomprimiendo archivo..."
tar -zxvf "$ARCHIVO"

echo "3. Renombrando carpeta de '$CARPETA_ORIGINAL' a '$CARPETA_NUEVA'..."
if [ -d "$CARPETA_ORIGINAL" ]; then
    mv "$CARPETA_ORIGINAL" "$CARPETA_NUEVA"
else
    echo "Error: La carpeta '$CARPETA_ORIGINAL' no existe. Verifica su nombre."
    exit 1
fi

echo "4. Borrando archivo comprimido..."
rm "$ARCHIVO"

echo "¡Proceso terminado con éxito!"
