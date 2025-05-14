#!/bin/bash
# /usr/local/bin/montar_drive.sh

MOUNT_POINT="/home/gerar_kde/One_Drive"
LOG_FILE="/var/log/montar_onedrive.log"
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"

# Limitar tamaño del log principal
if [ -f "$LOG_FILE" ] && [ "$(wc -l < "$LOG_FILE")" -gt 500 ]; then
    tail -n 200 "$LOG_FILE" > "${LOG_FILE}.tmp" && mv "${LOG_FILE}.tmp" "$LOG_FILE"
fi

# Redirigir salida estándar y de errores al log principal
exec > "$LOG_FILE" 2>&1

# Copiar al log de historial en /home/gerar_kde/.logs
if [ -d "$DEST_DIR" ]; then
    cp "$LOG_FILE" "$DEST_LOG"
    echo "[Info] Log copiado a $DEST_LOG"
else
    echo "[Warning] No se pudo copiar el log a $DEST_DIR (no existe)"
fi

echo "[$TIMESTAMP] Inicio del montaje de Google Drive"

# Verifica si ya está montado
if mountpoint -q "$MOUNT_POINT"; then
    echo "Google Drive ya está montado en $MOUNT_POINT"
    exit 0
fi

# Verifica que el punto de montaje exista
if [ ! -d "$MOUNT_POINT" ]; then
echo "Error: el directorio $MOUNT_POINT no existe."
exit 1
fi

# Verifica si hay conectividad antes de montar
if ! ping -c 1 -W 2 www.googleapis.com &> /dev/null; then
    echo "No hay conexión a internet. Reintentará más tarde..."
    exit 2
fi

# Ejecuta rclone en modo foreground (sin --daemon, lo controla systemd)
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
