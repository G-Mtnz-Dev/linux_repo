# **CLAVE SSH**

## **GENERAR UNA NUEVA CLAVE SSH**

**Utilizamos  como etiqueta, el correo electrónico de la Cta de GitHub:**

`**ssh-keygen -t ed25519 -C "dev············@··.com"**`

_Generating public/private ed25519 key pair._

_Enter file in which to save the key (/home/gerar\_kde/.ssh/id\_ed25519):_

_(empty to leave by default)_

_\----------------------------------------------------------_

_Created directory '/home/gerar\_kde/.ssh'._

_Enter passphrase (empty for no passphrase):_

_\----------------------------------------------------------_

_Enter same passphrase again:_

_(empty to leave by default)_  
_\----------------------------------------------------------_

_The key fingerprint is:_

_SHA256:bBCvv7BrlGiarNQEtNcTTtW4G3Yzp0GzYJ9YZILo1f0 dev.gmartinez@gmail.com_

_The key's randomart image is:_

### **AGREGAR LA CLAVE SSH**

En GitHub en **Cuenta / settings / 🔑SSH and GPG keys / New SSH key**

copiar la clave pública 

`**cat ~/.ssh/id_ed25519.pub**`

ssh-ed25519 AAAAC3xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxsF+072S dev.xxxxxxxxxnez@gmail.com

---