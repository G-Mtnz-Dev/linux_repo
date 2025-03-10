# **KDE PLASMA UTILIDADES** \[Goto PDF\]

## **GOOGLE DRIVE CON RCLONE**

Fuente (Ver primero el video):    [https://www.youtube.com/watch?v=_0BYb_OQsE4](https://www.youtube.com/watch?v=_0BYb_OQsE4)    y     [https://aprendolinux.com/conecta-google-drive-en-linux-con-rclone/](https://aprendolinux.com/conecta-google-drive-en-linux-con-rclone/) 

### `**INSTAL Y CONFIG RCLONE**`

`**sudo apt-get install rclone**`

#### **CONFIGURACIÓN** `**RCLONE**`

**PASO A PASO**

`**rclone config**`

*   Selecciona la opción para **agregar un nuevo remoto**. 

             En este caso, seleccionaremos “n” y presionaremos Enter.

*   **Elige un nombre para tu remoto.** Este nombre será utilizado para referirse a tu conexión Google Drive en rclone. 

              Puedes usar cualquier nombre descriptivo que desees.

*   **Selecciona el tipo de almacenamiento** que usarás. 

             Para Google Drive, selecciona drive (13) y presiona Enter.

*   **Configura** la aplicación de **Google Drive**. Sigue las instrucciones que aparecen en la terminal para **obtener el token de autorización**. 

              Esto te permitirá acceder a tu Google Drive desde rclone.

*   Selecciona los **ajustes de configuración predeterminados.** Para la mayoría de los casos, los ajustes predeterminados son adecuados. 

               O también puedes personalizarlos según tus necesidades.

*   **Revisa tu configuración**. Una vez que hayas completado la configuración, rclone te mostrará un resumen de tus opciones. Verifica que todo esté correcto.

              confirma la configuración.

**EN UNA SOLA ORDEN**

*   Utiliza directamente este comando:

`**rclone config create gdrive drive**`

            Se abrirá un navegador ante ti y permite configurar tu cuenta de Google con rclone.

### **MONTAR GDRIVE CON RCLONE** 

*   **Crear la Carpeta** donde se montará Drive

`**mkdir Drive**`

*   **Montar Drive** en la Carpeta

`**rclone mount gdrive: ~/Drive &  # (**`Se pone “**&**” para que monte el servicio y salga, y no se quede ahí pillado )#

---

## **ACTUALIZACIÓN y LIMPIEZA DEL SISTEMA:** 

*   **UPDATE:** 

             actualiza la lista de paquetes para comprobar si hay nuevos.

`**sudo apt update**`

*   **UPGRADE** y **FULL-UPGRADE**: 

             actualiza los paquetes instalados. Full   actualiza tanto los paquetes instalados como otros del sistema como el kernel.

`**sudo apt upgrade**`

`**sudo apt full-upgrade**`

*   **REFRESH**: 

             actualiza los paquetes instantáneos.

`**sudo snap refresh**`

*   **AUTOCLEAN** y **CLEAN**: 

             eliminan el caché local de paquetes.

`**sudo apt autoclean**`

`**sudo apt clean**`

*   **AUTOREMOVE**: 

             elimina todos los paquetes que ya no son necesarios. Suele ocurrir cuando se desinstala algún programa y quedan dependencias de este que ya no se usan.

`**sudo apt autoremove**`

`**sudo apt autoremove** **--PURGE** # (**OJO!!**` elimina todos los ficheros relacionados (configuración, etc.) de los paquetes desinstalados )# 

ión , dependiendo de lo que borres podría eliminar archivos importantes (no suele ser normal). _sudo apt autoremove --purge_

### **LIMPIAR Y ACTUALIZAR EN UNA ORDEN**

Se puede utiizar una sola orden uniéndolas con doble&  **'&&'**

`**sudo apt upgrade && sudo apt upgrade && sudo apt full-upgrade && sudo snap refresh && sudo apt autoclean && sudo apt clean && sudo apt autoremove**`

---

## **MONTAR  DESMONTAR  UNIDADES**

### **MONTAR UNIDADES**

Fuente:   [sanchezcorbalan.es](https://sanchezcorbalan.es/)   https://sanchezcorbalan.es/montar-particiones-en-linux-mount/

Para realizar esta tarea de forma manual existe el comando mount que tiene la siguiente sintaxis:

`**mount -t <fstype> <device> <dir>**`

**fstype:** Es el tipo de sistema de ficheros que se va a montar (ext4, ntfs, etc.).

**device:** Hace referencia a la partición física. Lo más habitual es que sea un fichero dentro de /dev/ (como /dev/sdb1) pero también puede ser un identificador único, una etiqueta o la ruta de un recurso de red.

**dir:** El directorio donde se incorpora el sistema de ficheros, normalmente en /media o en /mnt. Debe estar vacío, en caso contrario se sustituirá el contenido, aunque se volverá a restaurar cuando se desmonte la nueva partición.

Datos de mi partición:

Ruta Física: **/dev/sda3**

sistema ficheros **NTFS**

Etiqueta **Datos**

UUID **524F567904D39ECB**

**Por el directorio donde está montado** 

`**sudo mount -t ntfs /dev/sda3 /media/DATOS/**`

**Por el UUID**

`**sudo mount -t ntfs UUID=524F567904D39ECB /media/DATOS/**`

### **DESMONTAR UNIDADES**

Para desmontar un dispositivo usamos la orden **umount** pero con un único parámetro. Podemos elegir el directorio donde está montado o la ruta física de la partición.

`**sudo umount /dev/sda3**`

ó

`**sudo umount /media/DATOS/**`

---