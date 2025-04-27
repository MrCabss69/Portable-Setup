# ~/.bashrc

# Fuente definiciones globales
[ -f /etc/bashrc ] && . /etc/bashrc

# Cargar scripts en ~/.bashrc.d/
if [ -d "$HOME/.bashrc.d" ]; then
  for file in "$HOME/.bashrc.d/"*; do
    [ -f "$file" ] && . "$file"
  done
fi

# Load shared configs
[ -f "$HOME/.commonrc.d/load_common.sh" ] && source "$HOME/.commonrc.d/load_common.sh"
