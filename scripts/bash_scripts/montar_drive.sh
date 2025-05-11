#!/bin/bash

/usr/bin/rclone mount \
 gdrive: /home/gerar_kde/Drive \
 --vfs-cache-mode writes \
 --allow-non-empty