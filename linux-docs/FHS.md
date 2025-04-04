# FHS

La estructura de directorios en Linux es jerárquica, comenzando desde la raíz (`/`).

**Directorios Principales (Directamente bajo `/`)**

| Directorio | Descripción Corta                                                                  | Contenido Típico                                                                 |
| :--------- | :--------------------------------------------------------------------------------- | :------------------------------------------------------------------------------- |
| `/`        | **Directorio Raíz (Root Directory)**. El inicio de toda la jerarquía.                | Todos los demás directorios.                                                     |
| `/bin`     | **Binarios Esenciales del Usuario.** Comandos básicos necesarios para todos los usuarios, disponibles incluso si `/usr` no está montado (modo monousuario). | `ls`, `cp`, `mv`, `cat`, `bash`, `chmod`, `ping`, etc.                             |
| `/boot`    | **Archivos de Arranque.** Todo lo necesario para iniciar el sistema operativo.       | Kernel (vmlinuz), initramfs/initrd, gestor de arranque (GRUB).                   |
| `/dev`     | **Archivos de Dispositivo (Device Files).** Representan dispositivos de hardware.    | `/dev/sda` (disco), `/dev/tty1` (terminal), `/dev/null`, `/dev/random`, etc.   |
| `/etc`     | **Configuración del Sistema (Etcetera).** Archivos de configuración globales.        | `/etc/passwd`, `/etc/fstab`, `/etc/hostname`, `/etc/hosts`, `/etc/ssh/sshd_config` |
| `/home`    | **Directorios Personales de Usuarios.** Cada usuario (no root) tiene su subdirectorio. | `/home/usuario1`, `/home/usuario2`, etc. (Contienen Documentos, Descargas...)   |
| `/lib`     | **Bibliotecas Esenciales.** Bibliotecas compartidas necesarias para `/bin` y `/sbin`. | Archivos `.so` (Shared Objects) requeridos por los comandos básicos.            |
| `/lib64`   | **Bibliotecas Esenciales (64 bits).** Ídem a `/lib`, pero para sistemas de 64 bits. | Archivos `.so` de 64 bits.                                                      |
| `/media`   | **Puntos de Montaje para Medios Extraíbles.** CDs, DVDs, USBs (a menudo gestionado automáticamente). | `/media/cdrom`, `/media/usb_drive`, etc.                                         |
| `/mnt`     | **Punto de Montaje Temporal (Mount).** Para montar sistemas de archivos manualmente de forma temporal. | Vacío por defecto. Usado para montar particiones, NFS, etc., manualmente.       |
| `/opt`     | **Software Opcional/Adicional.** Paquetes de software de terceros, autocontenidos. | `/opt/google/chrome`, `/opt/slack`, etc.                                         |
| `/proc`    | **Sistema de Archivos Virtual de Procesos.** Información dinámica sobre el kernel y los procesos. | `/proc/cpuinfo`, `/proc/meminfo`, `/proc/<PID>/` (información por proceso).     |
| `/root`    | **Directorio Personal del Usuario Root.** El "home" del superusuario.               | Archivos de configuración y datos privados de root.                             |
| `/run`     | **Datos de Tiempo de Ejecución (Runtime).** Información volátil del sistema desde el último arranque. | Archivos PID, sockets de comunicación entre procesos.                            |
| `/sbin`    | **Binarios Esenciales del Sistema (System Binaries).** Comandos de administración del sistema. | `reboot`, `shutdown`, `fdisk`, `mkfs`, `ip`, `ifconfig`, `service`.              |
| `/srv`     | **Datos para Servicios (Serve).** Datos específicos de servicios ofrecidos por el sistema. | `/srv/http` (datos web), `/srv/ftp` (datos FTP). (Uso menos estandarizado).     |
| `/sys`     | **Sistema de Archivos Virtual del Sistema (System).** Información sobre hardware y drivers. | Similar a `/proc`, pero más estructurado para la interacción con el kernel/hardware. |
| `/tmp`     | **Archivos Temporales.** Cualquier usuario puede escribir aquí. Se suele limpiar al reiniciar. | Archivos temporales creados por aplicaciones.                                    |
| `/usr`     | **Recursos del Sistema Unix (Unix System Resources).** La jerarquía "secundaria". Contiene la mayoría de los programas y datos de usuario (no críticos para el arranque). | Ver detalles abajo.                                                              |
| `/var`     | **Archivos Variables.** Datos que cambian durante la operación normal (logs, caches, correo). | Ver detalles abajo.                                                              |

**Subdirectorios Importantes dentro de `/usr`**

| Directorio       | Descripción                                                                    |
| :--------------- | :----------------------------------------------------------------------------- |
| `/usr/bin`       | Binarios no esenciales de usuario (la mayoría de los programas que instalas).  |
| `/usr/sbin`      | Binarios no esenciales de administración del sistema.                           |
| `/usr/lib`       | Bibliotecas para los programas en `/usr/bin` y `/usr/sbin`.                    |
| `/usr/lib64`     | Bibliotecas de 64 bits para `/usr`.                                           |
| `/usr/local`     | Jerarquía para software instalado localmente (compilado desde fuente, etc.). Tiene su propia estructura `bin`, `lib`, `etc`, `share`. |
| `/usr/share`     | Datos compartidos independientes de la arquitectura (documentación, iconos...). |
| `/usr/include`   | Archivos de cabecera (header files) para programación en C/C++.                |
| `/usr/src`       | Código fuente (a menudo, el código fuente del kernel).                         |

**Subdirectorios Importantes dentro de `/var`**

| Directorio       | Descripción                                                              |
| :--------------- | :----------------------------------------------------------------------- |
| `/var/log`       | **Archivos de Registro (Logs).** Mensajes del sistema, kernel, servicios. |
| `/var/cache`     | Datos de caché de aplicaciones.                                          |
| `/var/spool`     | Colas de trabajo (impresión, correo, tareas `at`/`cron`).                 |
| `/var/mail`      | Buzones de correo de los usuarios (si se usa un sistema local).          |
| `/var/tmp`       | Archivos temporales que deben persistir entre reinicios (a diferencia de `/tmp`). |
| `/var/lib`       | Información de estado variable de programas (ej. bases de datos).         |
| `/var/www`       | Contenido de servidores web (ubicación común, aunque no estrictamente FHS). |

**Puntos Clave:**

*   **Sensible a Mayúsculas/Minúsculas:** `archivo.txt` es diferente de `Archivo.txt`.
*   **Separador de Directorios:** Se usa la barra inclinada (`/`).
*   **`/bin`, `/sbin`, `/lib` vs. `/usr/bin`, `/usr/sbin`, `/usr/lib`:** Históricamente, `/usr` podía ser una partición separada. Los directorios fuera de `/usr` contenían lo esencial para arrancar y montar `/usr`. Muchas distribuciones modernas ahora enlazan `/bin` a `/usr/bin`, `/sbin` a `/usr/sbin`, etc. (fusión `usrmerge`).
*   **No Modificar sin Saber:** Evita borrar o modificar archivos fuera de tu directorio `/home` a menos que sepas exactamente lo que estás haciendo, especialmente en `/etc`, `/bin`, `/sbin`, `/lib`, `/boot`.
