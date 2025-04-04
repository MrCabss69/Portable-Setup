# ~/.commonsrc.d/01-envs.sh

# PYENV
export PYENV_ROOT="$HOME/.pyenv"
[ -d "$PYENV_ROOT/bin" ] && PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv virtualenv-init -)"
fi

# PIPX
export PIPX_BIN_DIR="$HOME/.local/bin"
PATH="$PIPX_BIN_DIR:$PATH"
