#!/bin/bash
#
# description: Start and stop daemon script for.
VERDE='\033[0;32m'
SIN_COLOR='\033[0m'
# Definición de variables globales
export JUPYTER_DIR="$HOME/jupyter"
PID_FILE="$JUPYTER_DIR/jupyter.pid"
WORKSPACE_JUPYTER="$WORKSPACE/$NOTEBOOK_JUPYTER"
USAGE="Uso: $0 {start|stop|status}"
SET_ERROR="OK"
# Función para iniciar el servicio
start() {
    echo "Iniciando el servicio..."
 

    if [ ! -f "$PID_FILE" ]; then

   
        nohup jupyter notebook --NotebookApp.token='' --NotebookApp.password='' --notebook-dir="$WORKSPACE_JUPYTER" > $PID_FILE 2>&1 &
        
        # 3. Guardas el PID en un archivo de texto para poder usarlo después en 'stop'
        local pid=$!
        echo "$pid" > "$PID_FILE"
         printf "%-60s [  ${VERDE}OK${SIN_COLOR}  ]\n" "Jupyter Notebook is active"
        # echo "Servicio iniciado con el PID: $pid"
        # Añade aquí tus comandos reales para arrancar el programa
        # Ejemplo: /ruta/a/mi/programa --daemon
        # nohup jupyter notebook --NotebookApp.token='' --NotebookApp.password='' --notebook-dir="$PROJECT_DIR/$NOTEBOOK_JUPYTER" > /home/vscode/jupyter.log 2>&1 &
    else    

        printf "%-60s [  ${VERDE}OK${SIN_COLOR}  ]\n" "Jupyter Notebook is alive"

    fi
}

# Función para detener el servicio
stop() {
    echo "Deteniendo el servicio..."
    # Añade aquí tus comandos reales para detener el programa
    # Ejemplo: killall mi_programa
    if [ -f "$PID_FILE" ]; then
        # Leemos el PID que guardamos previamente
        local pid=$(cat "$PID_FILE")

        # Enviamos la señal para terminar el proceso
        kill "$pid"
        local fecha=$(date +"%Y-%m-%d_%H-%M-%S")

        # Mover y renombrar el archivo PID en lugar de borrarlo
        mv "$PID_FILE" "${JUPYTER_DIR}/${fecha}_pid.log"
         printf "%-60s [  ${VERDE}OK${SIN_COLOR}  ]\n" "Jupyter Notebook is shutdown"
    else
        printf "%-60s [  ${VERDE}!!${SIN_COLOR}  ]\n" "Jupyter Notebook is no runnig"
    fi
    # jupyter notebook stop 8888
    # kill $(pgrep -f jupyter)
}

# Función opcional para verificar el estado
status() {
    echo "Verificando el estado del servicio..."
    if [ -f "$PID_FILE" ]; then
        echo "El servicio está CORRIENDO con el PID: $(cat $PID_FILE)"
    else
        echo "El servicio está DETENIDO."
    fi

}

# Bloque de control principal (Evaluación del argumento $1)
case "${1}" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    status)
        status
        ;;
    *)
        echo "$USAGE"
        exit 1
        ;;
esac
