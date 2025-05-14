#!/bin/bash
# /usr/local/bin/montar_onedrive.sh

MOUNT_POINT="/home/gerar_kde/One_Drive"
LOG_FILE="/var/log/montar_onedrive.log"
DATE_SUFFIX="$(date '+%Y-%m-%d')"
DEST_DIR="/home/gerar_kde/.logs"
DEST_LOG="$DEST_DIR/montar_drive_$DATE_SUFFIX.log"
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"

# Limitar tamaño del log principal
if [ -f "$LOG_FILE" ] && [ "$(wc -l < "$LOG_FILE")" -gt 500 ]; then
    tail -n 200 "$LOG_FILE" > "${LOG_FILE}.tmp" && mv "${LOG_FILE}.tmp" "$LOG_FILE"
fi

# Registro inicial
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

# Verifica si hay conectividad antes de montar
if ! ping -c 1 -W 2 www.googleapis.com &> /dev/null; then
    echo "No hay conexión a internet. Reintentará más tarde..." >> "$LOG_FILE"
    exit 2
fi

# Ejecuta rclone en modo foreground (sin --daemon, lo controla systemd)
exec /usr/bin/rclone mount \
    onedrive: "$MOUNT_POINT" \
    --vfs-cache-mode writes \
    --allow-other \
    --dir-cache-time 1h \
    --poll-interval 1m \
    --timeout 1m \
    --umask 002 \
    --log-level INFO \
    --log-file "$LOG_FILE"