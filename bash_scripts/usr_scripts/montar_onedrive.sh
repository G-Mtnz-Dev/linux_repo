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


