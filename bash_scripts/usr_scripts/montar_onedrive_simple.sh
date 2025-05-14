#!/bin/bash
# /usr/local/bin/montar_onedrive.sh

MOUNT_POINT="/home/gerar_kde/One_Drive"
LOG_FILE="/var/log/montar_onedrive.log"
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"

# Redirige toda la salida al archivo de log (sobrescribe)
exec > "$LOG_FILE" 2>&1

echo "[$TIMESTAMP] Iniciando montaje de OneDrive..."

# Verifica si ya está montado
if mountpoint -q "$MOUNT_POINT"; then
    echo "OneDrive ya está montado en $MOUNT_POINT."
    exit 0
fi

# Verifica que el directorio de montaje existe
if [ ! -d "$MOUNT_POINT" ]; then
echo "Error: el directorio $MOUNT_POINT no existe."
exit 2
fi

# Montar con rclone
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Ejecutando rclone mount..." >> "$LOG_FILE"

# Este exec reemplazará el script por rclone solo si llega hasta aquí
exec /usr/bin/rclone mount \
    gdrive: "$MOUNT_POINT" \
    --vfs-cache-mode writes \
    --allow-other \
    --dir-cache-time 1h \
    --poll-interval 1m \
    --timeout 1m \
    --umask 002 \
    --log-level INFO \
    --log-file "$LOG_FILE"

# Si exec falla, se ejecutará esta parte (lo cual no debería pasar normalmente)
# Copia el log al directorio del usuario (solo si no fue reemplazado por exec)
if [ -d "$DEST_DIR" ]; then
    cp "$LOG_FILE" "$DEST_LOG"
    echo "[Info] Log copiado a $DEST_LOG" >> "$LOG_FILE"
else
    echo "[Warning] No se pudo copiar el log a $DEST_DIR (no existe)" >> "$LOG_FILE"
fi

exit 0

