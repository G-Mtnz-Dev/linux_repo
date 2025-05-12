#!/bin/bash
# /usr/local/bin/montar_drive.sh

MOUNT_POINT="/home/gerar_kde/Drive"
LOG_FILE="/var/log/montar_drive.log"
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"

# Redirige salida estándar y de errores al log (sobrescribe)
exec > "$LOG_FILE" 2>&1

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

