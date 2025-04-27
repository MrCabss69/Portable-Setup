## 📄  Herramientas para un entorno Linux avanzado

> Este documento lista herramientas y comandos útiles a instalar en un sistema Linux (Fedora/DNF) para construir un entorno versátil, potente y modular. Clasificadas por categoría y con una breve descripción para cada una.

---

## 🔧 INSTALACIÓN RÁPIDA

### Instala todo de golpe (puedes quitar lo que no te interese):

```bash
sudo dnf install tmux fzf ripgrep fd-find bat htop tldr \
tree zsh neovim python3-pip git delta lsof strace \
direnv ncdu btop jq
```

> ⚠️ Algunas herramientas no están en los repositorios de Fedora directamente. En esos casos se instala vía `pipx`, `cargo`, `npm`, etc.

---

## 🧩 CATEGORÍAS Y HERRAMIENTAS

### 🖥️ Terminal & productividad

| Comando      | Descripción                                   |
|--------------|-----------------------------------------------|
| `tmux`       | Multiplexor de terminal para sesiones persistentes y splits |
| `fzf`        | Búsqueda fuzzy en cualquier lista (historial, archivos, etc.) |
| `bat`        | Mejorado `cat` con sintaxis y numeración      |
| `btop`       | Monitor de sistema visual y moderno           |
| `htop`       | Monitor de procesos interactivo               |
| `tldr`       | Versiones simplificadas de páginas man        |
| `tree`       | Ver estructura de carpetas en forma visual    |
| `ncdu`       | Análisis de uso de disco                      |
| `zoxide`     | Navegación rápida entre carpetas (`cd` inteligente) |

### 🛠️ Desarrollo

| Comando      | Descripción                                     |
|--------------|-------------------------------------------------|
| `neovim`     | Editor de texto para desarrolladores power-users |
| `git`        | Control de versiones                            |
| `delta`      | Coloreado avanzado para `git diff`              |
| `direnv`     | Carga automática de variables por proyecto      |
| `jq`         | Procesamiento de JSON en terminal               |
| `fd-find`    | Reemplazo rápido y moderno de `find` (`fd`)     |
| `ripgrep`    | Reemplazo veloz de `grep` (`rg`)                |

### 🧪 Análisis / Debug

| Comando      | Descripción                        |
|--------------|------------------------------------|
| `lsof`       | Ver qué procesos usan qué archivos |
| `strace`     | Trazar llamadas del sistema        |
| `gdb`        | Debugger para código compilado     |
| `tcpdump`    | Análisis de tráfico de red         |

---

## 📦 Herramientas útiles desde `pipx`

> Asegúrate de tener `pipx` instalado y en el PATH:

```bash
python3 -m pip install --user pipx
pipx ensurepath
```

### Comandos útiles:

```bash
pipx install poetry       # Gestión de proyectos Python moderna
pipx install black        # Formateador automático de Python
pipx install flake8       # Linter de código
pipx install httpie       # Cliente HTTP en CLI
pipx install cookiecutter # Plantillas de proyectos
pipx install jupyterlab   # Entorno interactivo para ciencia de datos
```

---

## 🧱 Herramientas desde otras fuentes

### 🧰 Cargo (Rust):

```bash
# Requiere Rust instalado: https://rustup.rs/
cargo install zoxide
cargo install exa         # Reemplazo moderno de `ls`
cargo install broot       # Navegador de archivos interactivo
```

### 🐢 Node.js / npm:

```bash
npm install -g gitmoji-cli
npm install -g serve
npm install -g degit
```

---

## 🛡️ Seguridad & Pentesting (opcionales)

```bash
sudo dnf install nmap hydra john hashcat wireshark aircrack-ng
```

---

## 🧠 Comandos para recordar

```bash
# Buscar dentro de archivos rápidamente
rg "texto"

# Navegar a carpetas anteriores automáticamente
z some-folder

# Ver el árbol de procesos
btop

# Carga automática de entornos
echo "layout python" > .envrc && direnv allow
```

---

## ✅ Recomendación final

- No instales todo sin criterio: ve probando lo que **realmente te potencia**.
- Documenta tus decisiones en tu `README.md` o `linux-docs/`.
- Automatiza lo que uses más de dos veces.

---

¿Quieres que genere ya este archivo como contenido de texto para que lo copies directamente? ¿O lo dejo como `.md` preparado para integrarlo al repo y que el `setup_hacker.sh` lo use también como checklist?