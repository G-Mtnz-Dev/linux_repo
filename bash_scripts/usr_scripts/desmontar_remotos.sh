#!/bin/bash
#/usr/local/bin/desmontar_remotos.sh

# Rutas a tus puntos de montaje
DRIVE_MOUNT="/home/gerar_kde/Drive"
ONEDRIVE_MOUNT="/home/gerar_kde/One_Drive"

echo "[Shutdown] Intentando desmontar Google Drive y OneDrive..." >> /var/log/desmontar_drives.log

# Función para desmontar si está montado
desmontar_si_montado() {
MOUNT_PATH="$1"
if mount | grep -q "$MOUNT_PATH"; then
fusermount -u "$MOUNT_PATH" && echo "Desmontado: $MOUNT_PATH" >> /var/log/desmontar_drives.log || echo "Fallo al desmontar: $MOUNT_PATH" >> /var/log/desmontar_drives.log
else
echo "No montado: $MOUNT_PATH" >> /var/log/desmontar_drives.log
fi
}

desmontar_si_montado "$DRIVE_MOUNT"
desmontar_si_montado "$ONEDRIVE_MOUNT"

exit 0
