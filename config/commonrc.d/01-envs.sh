# ~/.commonrc.d/01-envs.sh
# Variables de entorno comunes específicas

# Python
export PYENV_ROOT="$HOME/.pyenv"
[ -d "$PYENV_ROOT/bin" ] && PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)" 2>/dev/null || true
export PYTHONDONTWRITEBYTECODE=1  # Evita generar archivos .pyc
export PYTHONUNBUFFERED=1         # Salida sin buffer para logs

# Editor
export EDITOR=nvim
export VISUAL=nvim

# Configuraciones personalizadas
# Añade aquí otras variables de entorno comunes 