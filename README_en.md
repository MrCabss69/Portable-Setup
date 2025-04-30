# ⏳⚙️ Portable-Setup

Portable configuration environment for Bash, Zsh, and advanced development on Linux. Modular, scalable, and portable.

---

## Structure and Operation

When you log in to your terminal:

1. The `.bashrc` or `.zshrc` file executes the line added by the setup scripts.
2. This line automatically loads all `*.bash` or `*.zsh` files in the `.bashrc.d/` or `.zshrc.d/` directories.
3. In turn, the common files in `.commonrc.d/` are loaded using `load_common.sh`.
4. Files are processed in alphanumeric order, allowing full priority control (`00-`, `01-`, ..., `99-local.*`).

### Main Directories

- `config/bashrc.d/` : Bash-specific scripts.
- `config/zshrc.d/` : Zsh-specific scripts.
- `config/commonrc.d/` : Common scripts for both shells.
- `cron.d/` : Cron job examples.
- `services.d/` : Systemd service examples.
- `linux-docs/` : Documentation and additional resources.

### Main Files

**In `~/.commonrc.d/`:**
- `00-paths.sh` : Safe handling of `$PATH`.
- `01-envs.sh` : Global environment variables.
- `02-aliases.sh` : Common aliases.
- `03-functions.sh` : Useful functions.
- `99-local.sh` : Private, unversioned configuration.
- `load_common.sh` : Common file loader.

**In `~/.bashrc.d/`:**
- `00-paths.bash` : Bash-specific PATH.
- `04-modules.bash` : Optional Bash modules.
- `99-local.bash` : Private customizations for Bash.

**In `~/.zshrc.d/`:**
- `00-core.zsh` : Zsh configuration core.
- `01-plugins.zsh` : Zsh plugin management.
- `99-local.zsh` : Private customizations for Zsh.

---

## Quick Install

1. Clone the repository:

```bash
git clone https://github.com/MrCabss69/Portable-Setup.git
cd Portable-Setup
```

2. Run the setup scripts depending on the shell you use:

```bash
./setup_commons.sh # Common configuration
./setup_bashrc.sh # For Bash
./setup_zshrc.sh # For Zsh
```

3. Install dependencies

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

4. Reboot / open a new terminal for the changes to take effect.

---

## Basic Testing

Open a new terminal and check:

```bash
# Verify loaded aliases
aliases | grep '^cat='

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
in `load_common.sh` or in the setup scripts.

---

## Personal Configuration (`99-local.*`)

The `99-local.*` file (in `commonrc.d`, `bashrc.d`, or `zshrc.d`) allows you to add private configurations like:

- Specific environment variables (e.g., `JAVA_HOME`, custom paths).
- Personal aliases or overrides of common aliases.
- Sensitive tokens or settings (though for secrets, consider using specialized managers).

**Basic Instructions:**

```bash
cp config/commonrc.d/99-local.example.sh config/commonrc.d/99-local.sh
nano config/commonrc.d/99-local.sh
```

Remember that `99-local.*` files are **ignored** in the `.gitignore` to avoid pushing sensitive data to Git.

---

## Cron jobs and systemd services

Installing cron jobs and services is not automatic. It requires manual action.

### User cron jobs

```bash
crontab -e
# Paste custom contents from a cron.d/ file
```

Or load directly:

```bash
cat cron.d/my-task.cron | crontab -
```

Verify the installation:

```bash
crontab -l
```

### User Services (systemd)

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

*(For system services, use `/etc/systemd/system/` and `sudo systemctl`.)*

---

## Advanced Recommendations

- Use `direnv` for dynamic per-project environment variables. - Use `pyenv` and `pyenv-virtualenv` for professional Python version management.
- Use `pipx` to install isolated CLI tools.
- Use `git-delta` to improve Git diff visualization.
- Use `lazygit` as a visual Git manager in the terminal.
- Automate common tasks by creating a `Makefile` or `justfile`.