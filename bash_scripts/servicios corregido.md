# **CORRECCIÓN**

### **🔍 1. Problemas posibles en tu script**

#!/bin/bash rclone mount --allow-non-empty gdrive: /home/gerar\_kde/Drive & exit

#### Problemas:

El & hace que el proceso se ejecute en segundo plano, y luego haces exit, lo que **mata el proceso del script junto con el montaje**, porque Type=simple espera que el proceso continúe.

\--allow-non-empty **no es recomendable**, puede causar errores si la carpeta ya tiene contenido.

No usas --vfs-cache-mode, que **es obligatorio** para muchas operaciones con rclone mount.

🔧 **Corregido:**

```
#!/bin/bash

/usr/bin/rclone mount \
 gdrive: /home/gerar_kde/Drive \
 --vfs-cache-mode writes \
 --allow-other
```

Asegúrate de que /home/gerar\_kde/Drive **existe** y que tienes permiso.

---

### **🛠️ 2. Corrección del archivo de servicio systemd**

Tu archivo actual tiene un problema en la línea de User=:

**User=gerar\_kde@Lap-Linux  # ❌ Esto es inválido**

**User= debe contener solo el nombre de usuario del sistema, no el hostname. Entonces debe ser:**

**User=gerar\_kde**

#### 🧪 Archivo corregido completo:

### \[Unit\]

Description=Montar Google Drive al inicio  
After=network-online.target  
Wants=network-online.target  
\[Service\]  
Type=simple  
User=gerar\_kde  
ExecStart=/usr/local/bin/montar\_drive.sh  
Restart=on-failure  
Environment=PATH=/usr/bin:/bin \[Install\]  
WantedBy=default.target

---

### ✅  3 - Pasos finales:

Revisa la ruta de \*\*rclone\*\*:

```
which rclone
```

Asegúrate de que es /usr/bin/rclone o cambia la ruta en el script si es diferente.

#### **3.1 Revisar logs del servicio:**

       Después de hacer sudo systemctl start montar\_drive.service, revisa con:

```
journalctl -u montar_drive.service --no-pager
```

      Ahí verás si falla algo como permisos, rutas, o errores de rclone.

### **4 - Recarga y reinicia el servicio Drive y OneDrive:**

```
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl restart montar_drive.service
```

```
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl restart montar_onedrive.service
```

## ERRORES

### **1 - UNIDAD D : no me deja crear carpetas (No soy adninistrador)**

#### **🔧 Problemas Identificados:**

**Permisos insuficientes:** El script intenta montar una unidad en `/media/DATOS`, pero si no estás ejecutando el script como root, no tienes permisos para montar ni para escribir en ese punto de montaje.

**Directorio** `**/media/DATOS**`**:** Por defecto, este directorio es propiedad de `root` y requiere permisos especiales para escritura o montaje.

#### **✅ Solucion**

#### Añadir una entrada en `/etc/fstab` para permitir el montaje sin sudo

Puedes permitir que el usuario monte la partición automáticamente o manualmente sin `sudo`. Para ello, edita el archivo `/etc/fstab`:

Abre el archivo con un editor de texto como root:

Añade una línea como esta:

```
UUID=524F567904D39ECB  /media/DATOS  ntfs3  rw,user,uid=1000,gid=1000,umask=022  0  0
```

`user`: permite que un usuario normal monte el sistema de archivos.

`uid=1000`, `gid=1000`: establece el propietario del punto de montaje.

`umask=022`: permisos predeterminados.

Ahora deberías poder montar la unidad Sin necesidad de `sudo`. con:

```
mount /media/DATOS
```

Sin necesidad de `sudo`.