#!/bin/bash
# /usr/local/bin/montar_datos.sh

mount -t ntfs3 -o rw,uid=1000,gid=1000,umask=022 UUID=524F567904D39ECB /mnt/Datos-D
