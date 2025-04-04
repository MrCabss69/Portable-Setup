# 🧰 Portable-Setup

> Entorno de configuración modular, portable y reproducible para Bash, Zsh y desarrollo avanzado en Linux.  
> Diseñado para desarrolladores, hackers y usuarios que quieren **control absoluto** sobre su terminal y herramientas.

---

## 🎯 Objetivo

Este repositorio permite:

- Tener un entorno reproducible entre máquinas y sesiones.
- Mantener limpio y separado el entorno para Bash y Zsh.
- Facilitar el versionado de alias, funciones, rutas, entornos virtuales, etc.
- Integrar herramientas de desarrollo modernas y utilidades CLI de forma controlada.
- Promover buenas prácticas: modularidad, claridad, automatización y portabilidad.

---

## ⚙️ Instalación

### 1. Clona el repo

```bash
git clone https://github.com/MrCabss69/Portable-Setup.git
cd Portable-Setup
```

### 2. Ejecuta los scripts de setup

```bash
./setup_common.sh         # Configuración común para Bash y Zsh
./setup_bashrc.sh         # Para usar Bash modular
./setup_zshrc.sh          # Para usar Zsh modular
```

> 🔐 Todos los scripts hacen backup de tus archivos originales (`.bashrc`, `.zshrc`) antes de modificar nada.

---

## 🧠 Estructura modular

### 🔧 `.bashrc.d/` y `.zshrc.d/`

- `00-paths.*` → añade rutas al `PATH` de forma segura
- `01-envs.*` → variables de entorno y herramientas como `pyenv`, `pipx`, etc.
- `02-aliases.*` → alias comunes (`ll`, `gs`, `spyder`, etc.)
- `03-functions.*` → funciones personalizadas (`cursor`, `cl`, etc.)
- `04-modules.*` → carga de módulos extra (si usas)
- `99-local.*` → configuraciones privadas (no versionadas)

### 🧩 `.commonrc.d/`

- Contiene configuración **compartida entre Bash y Zsh**
- Se carga automáticamente desde ambos shells gracias a `load_common.sh`

---

## 🧰 Herramientas recomendadas

> Ver [`linux-docs/hacker_tools.md`](linux-docs/hacker_tools.md)

Incluye:

- `fzf`, `ripgrep`, `fd-find`, `bat`, `tmux`, `zoxide`, `direnv`
- `pyenv`, `pipx`, `poetry`
- `git-delta`, `btop`, `tldr`, `lazygit`
- `konsole`, `p10k.zsh`

Instálalas con:

```bash
sudo dnf install fzf ripgrep fd-find bat tmux btop tldr
```

---

## 🧪 Recomendaciones avanzadas

- Usa `direnv` + `.envrc` para gestionar variables por proyecto
- Usa `pyenv` + `pyenv-virtualenv` para entornos Python
- Usa `pipx` para instalar herramientas CLI aisladas
- Agrega `delta` para diffs visuales en Git
- Automatiza tareas con `Makefile` o `just`

---

## 🧪 ¿Cómo testear que funciona?

```bash
alias | grep spyder
type cursor
echo $PYENV_ROOT
```

Debes ver:

- Alias definidos
- Funciones disponibles
- Variables de entorno cargadas

Si algo falla, depura con:

```bash
echo ">>> Cargando $file"  # en commonrc.d/load_common.sh
```

---

## 🧱 Plan futuro (roadmap)

- [ ] Script `setup_hacker.sh` que instale y configure todas las herramientas clave
- [ ] Integración con `direnv`, `task`, `navi`, `asciinema`, etc.
- [ ] Dotfile para `neovim` completo con `lazy.nvim` y LSP
- [ ] Instalador con `Makefile` o `justfile`
- [ ] Integración con entornos de ciencia de datos y DevOps

---

## 🧠 Filosofía

> *"No configures tu entorno para lo que haces hoy, configúralo para lo que quieres ser capaz de hacer mañana."*


---

## 🧪 ¡Hack the terminal! 🧪