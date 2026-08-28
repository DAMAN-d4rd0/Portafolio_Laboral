#!/bin/bash
# Detener la ejecución si ocurre cualquier error durante el proceso
set -e
set -x
echo "🐍 Instalando dependencias de Python..."
#pip3 install --no-cache-dir -r requirements.txt

echo "📦 Iniciando la configuración de Apache Zeppelin..."

# Definir rutas
ZEPPELIN_TARGET_DIR="/home/vscode/zeppelin"
DOWNLOAD_ZEPPELIN="/workspaces/Portafolio_Laboral"
ARCHIVO="zeppelin-0.12.1-bin-all.tgz"
# Comprobar si Zeppelin ya está instalado para no repetir la descarga si el contenedor se reconstruye
if [ ! -d "$ZEPPELIN_TARGET_DIR" ]; then
    echo "⬇️ Descargando Zeppelin (usando tu script original)..."
    mkdir -p "$ZEPPELIN_TARGET_DIR"
    URL="https://dlcdn.apache.org/zeppelin/zeppelin-0.12.1/zeppelin-0.12.1-bin-all.tgz"
    wget "$URL" "$TARGET_DIR"
    tar -zvf "$ARCHIVO" -C "$ZEPPELIN_TARGET_DIR"
    rm -rf "$DOWNLOAD_ZEPPELIN/$ARCHIVO"
    # Ejecutamos tu script original de descarga directamente desde su ubicación actual
    # Esto evita tener que copiarlo manualmente con 'cp'
    # bash ./config/download_zeppelin.sh 
    
    echo "✅ Descarga completa"
else
    echo "ℹ️ Zeppelin ya se encuentra instalado en $ZEPPELIN_TARGET_DIR Omitiendo descarga."
fi
