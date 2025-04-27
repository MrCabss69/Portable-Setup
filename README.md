# 🧰 Portable-Setup

> Entorno de configuración portable para Bash, Zsh y desarrollo avanzado en Linux.
> Para desarrolladores y usuarios avanzados que buscan control, reproducibilidad y consistencia en su terminal.

---

## ✨ Características

*   **Modular:** Configuración dividida en pequeños archivos lógicos (`paths`, `aliases`, `functions`, `envs`).
*   **Portable:** Diseñado para funcionar en diferentes distribuciones de Linux (con ajustes mínimos en paquetes).
*   **Reproducible:** Fácil de clonar y desplegar en nuevas máquinas.
*   **Separación de Shells:** Configuraciones específicas para Bash (`config/bashrc.d/`) y Zsh (`config/zshrc.d/`), con una base común (`config/commonrc.d/`).
*   **Configuración Local Segura:** Espacio para secretos y ajustes personales (`99-local.*`) sin versionarlos en Git.
*   **Instalación Segura:** Scripts de setup que hacen backup automático de tus archivos `.bashrc` y `.zshrc`.
*   **Extensible:** Incluye directorios para `cron.d` (tareas programadas) y `services.d` (servicios systemd).

---

## ⚙️ Instalación Rápida

1.  **Clona el Repositorio:**
    ```bash
    git clone https://github.com/MrCabss69/Portable-Setup.git
    cd Portable-Setup
    ```

2.  **Ejecuta los Scripts de Setup:**
    *(Elige según los shells que uses)*
    ```bash
    ./setup_commons.sh # Necesario para la configuración compartida
    ./setup_bashrc.sh  # Si usas Bash
    ./setup_zshrc.sh   # Si usas Zsh
    ```

    **¿Qué hacen estos scripts?**
    *   🔐 **Backup:** Crean una copia de seguridad de tu `.bashrc` y/o `.zshrc` existentes (ej: `.bashrc.backup.1678886400`).
    *   ✏️ **Modificación:** Añaden una línea al final de tu `.bashrc` / `.zshrc` para cargar la configuración modular desde los directorios `.d`.
    *   🔗 **Enlace Simbólico:** Crean enlaces simbólicos desde los directorios de configuración de este repositorio (`config/bashrc.d`, `config/zshrc.d`, `config/commonrc.d`) a tu directorio home (`~/.bashrc.d`, `~/.zshrc.d`, `~/.commonrc.d`).

    **Opción `--force`:**
    Si necesitas reinstalar o los enlaces ya existen, usa la opción `--force`:
    ```bash
    ./setup_bashrc.sh --force
    ```

3.  **Instala Dependencias Clave:**
    Este setup asume que ciertas herramientas están disponibles. Instálalas según tu distribución:

    *   **Fedora / RHEL:**
        ```bash
        sudo dnf install util-linux-user git bat fzf ripgrep fd-find tmux btop tldr git-delta lazygit zoxide
        ```
    *   **Debian / Ubuntu:**
        ```bash
        sudo apt update && sudo apt install util-linux git bat fzf ripgrep fd-find tmux btop tldr git-delta lazygit zoxide
        # Nota: 'bat' puede llamarse 'batcat' en algunas versiones (crea un alias 'bat -> batcat')
        ```
    *   **Arch Linux:**
        ```bash
        sudo pacman -Syu util-linux git bat fzf ripgrep fd tmux btop tldr git-delta lazygit zoxide
        ```

    *   **Otras Herramientas (Instalación Manual/Específica):**
        Consulta `linux-docs/ADV_TRICKS.md` y la documentación oficial para:
        *   `pyenv` & `pyenv-virtualenv` (Gestión de Python)
        *   `pipx` (Instalación de herramientas CLI Python aisladas)
        *   `poetry` (Gestión de dependencias Python)
        *   `p10k.zsh` (Tema Zsh)
        *   `direnv` (Variables de entorno por directorio)
        *   `neovim` (Editor de texto)

4.  **Abre un nuevo terminal:** ¡Los cambios deberían estar activos!

---

## 🧠 Estructura y Uso

El sistema carga la configuración en el siguiente orden:

1.  **Shell RC:** Tu `.bashrc` o `.zshrc` se ejecuta.
2.  **Loader Modular:** La línea añadida por los scripts `setup_*.sh` carga los archivos del directorio `.d` específico del shell (`~/.bashrc.d/*.bash` o `~/.zshrc.d/*.zsh`).
3.  **Loader Común:** Dentro de los archivos del shell (o directamente en el RC), se carga `~/.commonrc.d/load_common.sh`.
4.  **Archivos Comunes:** `load_common.sh` carga todos los archivos `*.sh` dentro de `~/.commonrc.d/`.
5.  **Orden de Carga:** Los archivos se cargan en orden alfanumérico (por eso los prefijos `00-`, `01-`, etc.). `99-local.*` se carga al final, permitiendo sobrescribir configuraciones anteriores.

**Directorios Principales (en el Repositorio):**

*   `config/bashrc.d/`: Scripts específicos para Bash (`*.bash`).
*   `config/zshrc.d/`: Scripts específicos para Zsh (`*.zsh`).
*   `config/commonrc.d/`: Scripts compartidos entre Bash y Zsh (`*.sh`). Contiene `load_common.sh`.
*   `cron.d/`: Plantillas o ejemplos de trabajos cron.
*   `services.d/`: Plantillas o ejemplos de unidades systemd.
*   `linux-docs/`: Documentación adicional.

**Archivos de Configuración:**

* **Archivos comunes (`~/.commonrc.d/`):**
  * `00-paths.sh`: Funciones de manejo de PATH y rutas comunes
  * `01-envs.sh`: Variables de entorno (PYENV, EDITOR, etc.)
  * `02-aliases.sh`: Alias comunes para ambos shells
  * `03-functions.sh`: Funciones shell útiles (cl, mkcd, cursor, etc.)
  * `99-local.sh`: Configuración personal no versionada
  * `load_common.sh`: Cargador de archivos comunes

* **Archivos Bash (`~/.bashrc.d/`):**
  * `00-paths.bash`: Rutas específicas de Bash
  * `04-modules.bash`: Carga de módulos específicos
  * `99-local.bash`: Configuración local específica de Bash

* **Archivos Zsh (`~/.zshrc.d/`):**
  * `00-core.zsh`: Configuración central de Zsh
  * `01-plugins.zsh`: Carga de plugins de Zsh
  * `99-local.zsh`: Configuración local específica de Zsh

---

## 🛠️ Configuración Personal (`99-local.*`)

Este es el lugar **recomendado** para TUS configuraciones personales que no quieres versionar:

*   **Secretos:** Tokens de API, contraseñas (¡aunque considera un gestor de secretos!).
*   **Rutas Específicas:** `JAVA_HOME` en tu máquina, rutas a software instalado manualmente (ej: `~/Programas/Swift`, `~/.local/apps/cursor`).
*   **Alias Personales:** Atajos que sólo tú usas.
*   **Sobrescrituras:** Si quieres cambiar un alias o función definido en los archivos comunes.

**¿Cómo usarlo?**

1.  Copia el ejemplo: `cp config/commonrc.d/99-local.example.sh config/commonrc.d/99-local.sh` (y/o para bash/zsh si es necesario).
2.  Edita `config/commonrc.d/99-local.sh` (o los equivalentes en `bashrc.d`/`zshrc.d`) con tus datos.
3.  El archivo `.gitignore` de este repositorio ya está configurado para ignorar `99-local.*`, así no subirás tus datos sensibles por error.

---

## ⏳ Cron Jobs (`cron.d`) y ⚙️ Servicios (`services.d`)

Estos directorios contienen ejemplos o plantillas para automatizar tareas.

*   **`cron.d/`:** Archivos para ejecutar comandos en momentos programados.
*   **`services.d/`:** Archivos `.service` para gestionar procesos de fondo con `systemd`.

**IMPORTANTE:** La instalación de estos **no es automática**. Requiere pasos manuales:

*   **Cron:**
    *   **Sistema:** Copiar archivos a `/etc/cron.d/` (requiere `sudo`). Usar con precaución.
    *   **Usuario:** Usar `crontab -e` para añadir las reglas al crontab del usuario (más seguro y portable).
*   **Systemd Services:**
    *   **Sistema:** Copiar archivos a `/etc/systemd/system/` y luego usar `sudo systemctl enable --now <servicio>.service`. Usar con precaución.
    *   **Usuario:** Copiar archivos a `~/.config/systemd/user/` y usar `systemctl --user enable --now <servicio>.service`. Generalmente preferible.

Consulta la documentación de `cron` y `systemd` para más detalles.

### 🔧 Instalación de Cron Jobs (Guía Paso a Paso)

Para instalar un cron job de usuario:

1. **Editar el archivo cron para adaptarlo a tus necesidades:**
   ```bash
   # Personaliza la ruta o comando según tu caso
   cp cron.d/safety.cron ~/mi-safety.cron
   nano ~/mi-safety.cron  # Edita según tus necesidades
   ```

2. **Añadir al crontab del usuario:**
   ```bash
   crontab -e            # Abre el editor de crontab
   # Añade el contenido del archivo o importa:
   cat ~/mi-safety.cron  # Copia manualmente el contenido al editor
   # O puedes añadirlo directamente si sabes lo que haces:
   cat ~/mi-safety.cron | crontab -
   ```

3. **Verificar la instalación:**
   ```bash
   crontab -l            # Lista los jobs instalados
   ```

### 🛠️ Instalación de Servicios Systemd (Guía Paso a Paso)

Para instalar un servicio de usuario (recomendado):

1. **Copiar y personalizar el servicio:**
   ```bash
   mkdir -p ~/.config/systemd/user/
   cp services.d/persistent_tmux.service ~/.config/systemd/user/
   # Editar si es necesario:
   nano ~/.config/systemd/user/persistent_tmux.service
   ```

2. **Recargar systemd para detectar el nuevo servicio:**
   ```bash
   systemctl --user daemon-reload
   ```

3. **Habilitar y iniciar el servicio:**
   ```bash
   systemctl --user enable persistent_tmux.service  # Auto-inicio con sesión
   systemctl --user start persistent_tmux.service   # Iniciar ahora
   ```

4. **Verificar estado:**
   ```bash
   systemctl --user status persistent_tmux.service
   ```
   
5. **Ver logs si hay problemas:**
   ```bash
   journalctl --user -u persistent_tmux.service
   ```

Para servicios de sistema (requiere root):

1. **Copiar el servicio (como root):**
   ```bash
   sudo cp services.d/jupyter.service /etc/systemd/system/
   sudo nano /etc/systemd/system/jupyter.service  # Personalizar
   ```

2. **Habilitar e iniciar:**
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable jupyter.service
   sudo systemctl start jupyter.service
   ```

3. **Verificar:**
   ```bash
   sudo systemctl status jupyter.service
   ```

---

## ✅ Testeo Básico

Abre un nuevo terminal y verifica que las cosas funcionan:

```bash
# ¿Se cargó un alias común? (Requiere 'bat' instalado)
command -v bat
alias | grep '^cat='

# ¿Se cargó una función común?
type cl
type cursor

# ¿Se cargó una variable de entorno común? (Requiere pyenv instalado y configurado)
echo $PYENV_ROOT

# ¿Se cargó una ruta/alias de tu 99-local.*? (Adapta al tuyo)
# alias | grep mypersonalalias
# echo $JAVA_HOME
```

Si algo falla, puedes añadir `echo "DEBUG: Cargando $file"` dentro de los bucles `for` en los scripts de setup o en `load_common.sh` para ver qué se está cargando.

---

## 🚀 Recomendaciones Avanzadas

*   **`direnv`:** Gestiona variables de entorno por proyecto automáticamente al entrar en un directorio (`.envrc`).
*   **`pyenv` + `pyenv-virtualenv`:** La mejor forma de gestionar múltiples versiones y entornos virtuales de Python.
*   **`pipx`:** Instala y ejecuta aplicaciones de línea de comandos Python en entornos aislados. ¡Genial para herramientas como `poetry`, `ansible`, `black`, etc.!
*   **`git-delta`:** Hace que tus `git diff`, `git log -p`, etc., sean mucho más legibles.
*   **`lazygit`:** Una TUI (Interfaz de Usuario en Terminal) fantástica para Git.
*   **Automatización:** Usa `Makefile` o `just` para definir tareas comunes del proyecto.

---

## 🗺️ Plan Futuro (Roadmap)

*   [ ] Script `setup_tools.sh` interactivo para instalar herramientas recomendadas.
*   [ ] Integración más profunda con `direnv`.
*   [ ] Ejemplo de configuración para `neovim` (LazyVim o similar).
*   [ ] Instalador/Gestor usando `Makefile` o `just`.
*   [ ] Más ejemplos y documentación para Ciencia de Datos y DevOps.

---

## 📄 Licencia

Este proyecto se distribuye bajo la Licencia MIT. Ver `LICENSE` para más detalles. (***Nota:** Asegúrate de añadir un archivo `LICENSE` al repositorio.*)

---

## 🧠 Filosofía

> *"No configures tu entorno para lo que haces hoy, configúralo para lo que quieres ser capaz de hacer mañana."*

---

🧪 **¡Hack the terminal!** 🧪