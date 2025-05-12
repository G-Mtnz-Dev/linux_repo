#!/bin/bash
#/usr/local/bin/montar_datos.sh

MOUNT_POINT="/media/DATOS"
UUID="524F567904D39ECB"
FS_TYPE="ntfs3"
LOG_FILE="/var/log/montar_datos.log"
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"

log() {
    echo "[$TIMESTAMP] $1" >> "$LOG_FILE"
}

# Comprobamos si ya está montado
if mountpoint -q "$MOUNT_POINT"; then
    log "La partición ya está montada en $MOUNT_POINT."
    exit 0
fi

# Comprobamos si el punto de montaje existe y tiene permisos
if [ ! -d "$MOUNT_POINT" ]; then
    log "Error: El directorio $MOUNT_POINT no existe."
    exit 1
fi

if [ ! -w "$MOUNT_POINT" ]; then
    log "Error: No tienes permisos de escritura en $MOUNT_POINT."
    exit 2
fi

# Intentamos montar
mount -t $FS_TYPE -o rw,uid=1000,gid=1000,umask=022 UUID=$UUID "$MOUNT_POINT"
STATUS=$?

if [ $STATUS -eq 0 ]; then
    log "Partición montada correctamente en $MOUNT_POINT."
else
    log "Error al montar la partición (código $STATUS)."
    exit $STATUS
fi
