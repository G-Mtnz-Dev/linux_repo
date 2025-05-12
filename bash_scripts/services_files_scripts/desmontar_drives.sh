#!/bin/bash

# Rutas de montaje - cambia si son diferentes
DRIVE_MOUNT="/home/gerar_kde/Drive"
ONEDRIVE_MOUNT="/home/gerar_kde/One_Drive"

log="/var/log/desmontar_drives.log"
echo "[`date`] Iniciando desmontaje de unidades" >> "$log"

desmontar_si_montado() {
    local punto="$1"
    if grep -qs "$punto" /proc/mounts; then
        echo "[`date`] Desmontando $punto" >> "$log"
        fusermount -u "$punto"
        if [ $? -eq 0 ]; then
            echo "[`date`] $punto desmontado correctamente." >> "$log"
        else
            echo "[`date`] Error al desmontar $punto" >> "$log"
        fi
    else
        echo "[`date`] $punto no está montado. Nada que desmontar." >> "$log"
    fi
}

desmontar_si_montado "$DRIVE_MOUNT"
desmontar_si_montado "$ONEDRIVE_MOUNT"

echo "[`date`] Desmontaje completado" >> "$log"

