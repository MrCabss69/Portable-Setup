# ⏳⚙️ Portable-Setup

[SPANISH](README.md)

A portable setup environment for Bash, Zsh, and advanced Linux development. Modular, scalable, and portable structure.

---

## Structure and Workflow

When you start a new terminal session:

1. The `.bashrc` or `.zshrc` file runs the line added by the setup scripts.
2. That line automatically loads all `*.bash` or `*.zsh` files in the `.bashrc.d/` or `.zshrc.d/` directories.
3. Additionally, shared files in `.commonrc.d/` are loaded via `load_common.sh`.
4. Files are processed in alphanumeric order, giving you full control over priority (`00-`, `01-`, ..., `99-local.*`).

### Main directories

* `config/bashrc.d/`: Bash-specific scripts.
* `config/zshrc.d/`: Zsh-specific scripts.
* `config/commonrc.d/`: Scripts shared by both shells.
* `cron.d/`: Example cron jobs.
* `services.d/`: Example systemd services.
* `linux-docs/`: Documentation and additional resources.

### Key files

**In `~/.commonrc.d/`:**

* `00-paths.sh`: Safe `$PATH` management.
* `01-envs.sh`: Global environment variables.
* `02-aliases.sh`: Common aliases.
* `03-functions.sh`: Handy functions.
* `99-local.sh`: Private, non-versioned configuration.
* `load_common.sh`: Loader for shared files.

**In `~/.bashrc.d/`:**

* `00-paths.bash`: Bash-specific `$PATH`.
* `04-modules.bash`: Optional Bash modules.
* `99-local.bash`: Private customizations for Bash.

**In `~/.zshrc.d/`:**

* `00-core.zsh`: Zsh core setup.
* `01-plugins.zsh`: Zsh plugin management.
* `99-local.zsh`: Private customizations for Zsh.

---

## Quick Installation

Clone the repository:

```bash
git clone https://github.com/MrCabss69/Portable-Setup.git
cd Portable-Setup
```

### Option 1: Manual installation

Run the setup scripts according to your shell:

```bash
./scripts/setup_tools.sh
```

Or, if preferred, use the Makefile:

```bash
make setup-bash
make test
```

Install recommended dependencies:

**Fedora / RHEL:**

```bash
sudo dnf install util-linux-user git bat fzf ripgrep fd-find tmux btop tldr git-delta lazygit zoxide
```

**Debian / Ubuntu:**

```bash
sudo apt update && sudo apt install util-linux git bat fzf ripgrep fd-find tmux btop tldr git-delta lazygit zoxide
```

*(Note: on Debian/Ubuntu, `bat` may be available as `batcat`.)*

**Arch Linux:**

```bash
sudo pacman -Syu util-linux git bat fzf ripgrep fd tmux btop tldr git-delta lazygit zoxide
```

Restart or open a new terminal to apply changes.

---

### Option 2: Master configuration script (`setup_tools.sh`)

In addition to the individual setup scripts, there’s a master script `setup_tools.sh` located in `scripts/` offering an interactive menu to:

* Configure `commonrc.d`
* Configure `bashrc.d`
* Configure `zshrc.d`
* Install recommended tools (essential packages)
* Exit

Example usage:

```bash
./scripts/setup_tools.sh
```

---

## Basic Testing

Open a new terminal and check:

```bash
# Check loaded aliases
alias | grep '^cat='

# Check functions
type cl
type cursor

# Check environment variables
echo $PYENV_ROOT
```

If something fails, you can add debug lines like:

```bash
echo "Loading $file"
```

in `load_common.sh` or the setup scripts.

Additionally, the project includes a `tests/` directory to automatically verify the integrity and behavior of the scripts:

```bash
cd tests
bash 01-test-estructura.sh
bash 02-test-setup-bashrc.sh
...
```

---

## Personal Configuration (`99-local.*`)

The `99-local.*` file (in `commonrc.d`, `bashrc.d`, or `zshrc.d`) allows you to add personal configurations such as:

* Specific environment variables (e.g., `JAVA_HOME`, custom paths),
* Personal aliases or overrides of common aliases,
* Tokens or sensitive configs (although for secrets, it's recommended to use dedicated managers).

**Basic instructions:**

```bash
cp config/commonrc.d/99-local.example.sh config/commonrc.d/99-local.sh
nano config/commonrc.d/99-local.sh
```

These `99-local.*` files are **ignored by Git** (see `.gitignore`) to prevent sensitive data from being committed.

---

## Cron Jobs and systemd Services

Installing cron jobs and services is manual.

### User cron jobs

```bash
crontab -e
# Paste the customized content from a cron.d/ file
```

Or load directly:

```bash
cat cron.d/my-task.cron | crontab -
```

Check installed cron jobs:

```bash
crontab -l
```

### User services (systemd)

```bash
mkdir -p ~/.config/systemd/user/
cp services.d/my-service.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now my-service.service
systemctl --user status my-service.service
```

Logs:

```bash
journalctl --user -u my-service.service
```

*(For system-wide services, use `/etc/systemd/system/` and `sudo systemctl`.)*

---

## Advanced Recommendations

* Use `direnv` for dynamic per-project environment variables,
* Use `pyenv` and `pyenv-virtualenv` for professional Python version management,
* Use `pipx` to install isolated CLI tools,
* Use `git-delta` for enhanced Git diffs,
* Use `lazygit` as a terminal-based Git UI,
* Automate common tasks by creating a `Makefile` or `justfile`.

---

### Bonus: Git-Ready CI/CD Project Initializer

This repository includes a complete template for Python OSS projects with:

* Preconfigured CI/CD (GitHub Actions),
* Automatic linters (flake8, black, isort),
* Pre-commit hooks,
* Integrated Dependabot.

📂 Location: `config/repo-templates/python/`

---

## 🗺️ Roadmap

* Advanced `direnv` integration,
* Examples of advanced `neovim` configuration (`lazy.nvim`),
* Installers via `Makefile` or `justfile`,
* Expansion into data science and DevOps environment setups.
