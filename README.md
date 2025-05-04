# ⏳⚙️ Portable-Setup

[ENGLISH](README_en.md)


Entorno de configuración portable para Bash, Zsh y desarrollo avanzado en Linux.  Estructura modular, escalable y portable.


---

## Estructura y funcionamiento

Al iniciar sesión en tu terminal:

1. El archivo `.bashrc` o `.zshrc` ejecuta la línea añadida por los scripts de setup.
2. Esa línea carga automáticamente todos los archivos `*.bash` o `*.zsh` en los directorios `.bashrc.d/` o `.zshrc.d/`.
3. A su vez, los archivos comunes de `.commonrc.d/` se cargan mediante `load_common.sh`.
4. Los archivos se procesan en orden alfanumérico, permitiendo control total de prioridades (`00-`, `01-`, ..., `99-local.*`).

### Directorios principales

- `config/bashrc.d/` : Scripts específicos para Bash.
- `config/zshrc.d/` : Scripts específicos para Zsh.
- `config/commonrc.d/` : Scripts comunes para ambos shells.
- `cron.d/` : Ejemplos de cron jobs.
- `services.d/` : Ejemplos de servicios systemd.
- `linux-docs/` : Documentación y recursos adicionales.

### Archivos principales

**En `~/.commonrc.d/`:**
- `00-paths.sh` : Manejo seguro del `$PATH`.
- `01-envs.sh` : Variables de entorno globales.
- `02-aliases.sh` : Alias comunes.
- `03-functions.sh` : Funciones útiles.
- `99-local.sh` : Configuración privada no versionada.
- `load_common.sh` : Cargador de archivos comunes.

**En `~/.bashrc.d/`:**
- `00-paths.bash` : PATH específico para Bash.
- `04-modules.bash` : Módulos opcionales de Bash.
- `99-local.bash` : Personalizaciones privadas para Bash.

**En `~/.zshrc.d/`:**
- `00-core.zsh` : Núcleo de configuración de Zsh.
- `01-plugins.zsh` : Gestión de plugins de Zsh.
- `99-local.zsh` : Personalizaciones privadas para Zsh.

---

## Instalación rápida

Clona el repositorio:

```bash
git clone https://github.com/MrCabss69/Portable-Setup.git
cd Portable-Setup
```

### Opción 1: Instalación manual

2. Ejecuta los scripts de setup según el shell que uses:

```bash
./setup_tools.sh
```

O si lo prefieres, usa el makefile

```bash
make setup-bash
make test
```

3. Instala dependencias 

**Fedora / RHEL:**
```bash
sudo dnf install util-linux-user git bat fzf ripgrep fd-find tmux btop tldr git-delta lazygit zoxide
```

**Debian / Ubuntu:**
```bash
sudo apt update && sudo apt install util-linux git bat fzf ripgrep fd-find tmux btop tldr git-delta lazygit zoxide
```
*(Nota: en Debian/Ubuntu `bat` puede estar disponible como `batcat`.)*

**Arch Linux:**
```bash
sudo pacman -Syu util-linux git bat fzf ripgrep fd tmux btop tldr git-delta lazygit zoxide
```

4. Reinicia / abre nuevo terminal para que los cambios tengan efecto.


### Opción 2: Script maestro de configuración (setup_tools.sh)

Además de los scripts individuales, dispones del script maestro setup_tools.sh ubicado en scripts/, que ofrece un menú interactivo para:

    - Configurar commonrc.d

    - Configurar bashrc.d

    - Configurar zshrc.d

    - Instalar herramientas recomendadas (paquetes clave)

    - Salir

Ejemplo de uso:
```bash
./scripts/setup_tools.sh
```
---


## Testeo básico

Abre un nuevo terminal y comprueba:

```bash
# Verificar alias cargados
alias | grep '^cat='

# Verificar funciones
type cl
type cursor

# Verificar variables de entorno
echo $PYENV_ROOT
```

Si algo falla, puedes agregar líneas de debug como:

```bash
echo "Cargando $file"
```
en `load_common.sh` o en los scripts de setup.

Además, el proyecto incluye una carpeta de tests (tests/) para verificar automáticamente la integridad y funcionamiento de los scripts.
```bash

cd tests
bash 01-test-estructura.sh
bash 02-test-setup-bashrc.sh
..
```

---


## Configuración personal (`99-local.*`)

El archivo `99-local.*` (en `commonrc.d`, `bashrc.d` o `zshrc.d`) te permite añadir configuraciones privadas como:

- Variables de entorno específicas (por ejemplo, `JAVA_HOME`, rutas personalizadas).
- Alias personales o sobrescrituras de alias comunes.
- Tokens o configuraciones sensibles (aunque para secretos, considera usar gestores especializados).

**Instrucciones básicas:**

```bash
cp config/commonrc.d/99-local.example.sh config/commonrc.d/99-local.sh
nano config/commonrc.d/99-local.sh
```

Recuerda que los archivos `99-local.*` **están ignorados** en el `.gitignore` para evitar subir datos sensibles a Git.

---

##  Cron jobs y servicios systemd

La instalación de cron jobs y servicios no es automática. Requiere acción manual.

### Cron jobs de usuario

```bash
crontab -e
# Pega el contenido personalizado de un archivo de cron.d/
```

O carga directamente:

```bash
cat cron.d/mi-tarea.cron | crontab -
```

Verifica la instalación:

```bash
crontab -l
```

### Servicios de usuario (systemd)

```bash
mkdir -p ~/.config/systemd/user/
cp services.d/mi-servicio.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now mi-servicio.service
systemctl --user status mi-servicio.service
```

Logs:

```bash
journalctl --user -u mi-servicio.service
```

*(Para servicios de sistema, usar `/etc/systemd/system/` y `sudo systemctl`.)*

---


## Recomendaciones avanzadas

- Usa `direnv` para variables de entorno dinámicas por proyecto.
- Usa `pyenv` y `pyenv-virtualenv` para gestión profesional de versiones de Python.
- Usa `pipx` para instalar herramientas CLI aisladas.
- Usa `git-delta` para mejorar la visualización de diferencias en Git.
- Usa `lazygit` como gestor visual de Git en terminal.
- Automatiza tareas comunes creando un `Makefile` o un `justfile`.

---


### Bonus: Inicializador de proyectos CI/CD para Git

Este repositorio incluye una plantilla completa para proyectos Python OSS con:

- CI/CD preconfigurado (GitHub Actions)
- Linters automáticos (flake8, black, isort)
- Pre-commit hooks
- Dependabot integrado

📂 Ubicación: `config/repo-templates/python/`


---

## 🗺️ Roadmap

- Integración avanzada con `direnv`.
- Ejemplos de configuración avanzada de `neovim` (`lazy.nvim`).
- Instaladores tipo `Makefile` o `justfile`.
- Expansión a configuraciones de entornos de ciencia de datos y DevOps.
