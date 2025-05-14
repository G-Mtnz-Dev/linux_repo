#!/bin/bash
#/lib/systemd/system-shutdown/desmontar_datos_d

DATOS_MOUNT="/media/DATOS"
PERSISTENT_LOG="/root/desmontar_datos_d.log"
DEST_DIR="/home/gerar_kde/.logs"
DATE_SUFFIX="$(date '+%Y-%m-%d')"
DEST_LOG="$DEST_DIR/desmontar_datos_d_$DATE_SUFFIX.log"

#limitarlo las últimas 200 líneas si el archivo pasa de 500.
if [ -f "$PERSISTENT_LOG" ] && [ "$(wc -l < "$PERSISTENT_LOG")" -gt 500 ]; then
tail -n 200 "$PERSISTENT_LOG" > "$PERSISTENT_LOG.tmp" && mv "$PERSISTENT_LOG.tmp" "$PERSISTENT_LOG"
fi

# Registro inicial
echo "[Shutdown] $(date '+%Y-%m-%d %H:%M:%S') - Intentando desmontar unidad D..." >> "$PERSISTENT_LOG"

# Función para copiar el log si existe el directorio destino
copiar_log_a_home() {
if [ -d "$DEST_DIR" ]; then
cp "$PERSISTENT_LOG" "$DEST_LOG"
echo "Log copiado a $DEST_LOG" >> "$PERSISTENT_LOG"
else
echo "Directorio de destino no encontrado: $DEST_DIR" >> "$PERSISTENT_LOG"
fi
}

# Función de desmontaje
desmontar_si() {
MOUNT_PATH="$1"
if mount | grep -q "$MOUNT_PATH"; then
copiar_log_a_home
umount -l "$MOUNT_PATH" && \
echo "Desmontado correctamente: $MOUNT_PATH" >> "$PERSISTENT_LOG" || \
echo "Fallo al desmontar: $MOUNT_PATH" >> "$PERSISTENT_LOG"
else
echo "No estaba montado: $MOUNT_PATH" >> "$PERSISTENT_LOG"
fi
}

desmontar_si "$DATOS_MOUNT"
exit 0

