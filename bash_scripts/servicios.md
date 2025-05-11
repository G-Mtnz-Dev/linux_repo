# **Crear un servicio systemd**

## **1 - Crear script de montaje**

```
#!/bin/bash
# /usr/local/bin/file-name.sh

rclone mount --allow-non-empty gdrive: /home/gerar_kde/Drive &

end
```

## **2 - Darle permisos de ejecución:**

```
sudo chmod +x /usr/local/bin/file-name_.sh
```

## 3 - Crear Archivo de Servicio systemd:

Ruta:  /etc/systemd/system/_file-name_.service  

```
[Unit]
Description=Montar Google Drive al inicio
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=gerar_kde@Lap-Linux
ExecStart=/usr/local/bin/montar_drive.sh
Restart=on-failure

[Install]
WantedBy=default.target
```

**4 - Habilitar el servicio al inicio:**

```
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable montar_drive.service
```

## **5 - Prueba el script sin reiniciar:**

```
sudo systemctl start montar_drive.service  
```