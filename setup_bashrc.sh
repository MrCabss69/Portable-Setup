#!/bin/bash

set -euo pipefail

# === CONFIG ===
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_BASHRC_D="$REPO_DIR/.bashrc.d"
TARGET_BASHRC_D="$HOME/.bashrc.d"
BASHRC="$HOME/.bashrc"
BASHRC_BACKUP="$HOME/.bashrc.backup.$(date +%s)"
FORCE=false

# === FUNCIONES ===

print_usage() {
  echo "Uso: $0 [--force]"
  echo "  --force   Sobrescribe enlaces simbólicos existentes"
}

parse_args() {
  for arg in "$@"; do
    case "$arg" in
      --force) FORCE=true ;;
      -h|--help) print_usage; exit 0 ;;
      *) echo "❌ Argumento desconocido: $arg"; print_usage; exit 1 ;;
    esac
  done
}

backup_bashrc() {
  echo "📦 Haciendo backup de .bashrc actual → $BASHRC_BACKUP"
  cp "$BASHRC" "$BASHRC_BACKUP"
}

ensure_loader_in_bashrc() {
  if ! grep -q 'bashrc\.d' "$BASHRC"; then
    echo "➕ Agregando loader modular a $BASHRC"
    cat <<'EOF' >> "$BASHRC"

# Load user-specific modular configuration
if [ -d "$HOME/.bashrc.d" ]; then
  for file in "$HOME/.bashrc.d/"*.bash; do
    [ -f "$file" ] && . "$file"
  done
fi
EOF
  else
    echo "✅ Loader modular ya presente en $BASHRC"
  fi
}

create_symlinks() {
  echo "🔗 Creando enlaces simbólicos desde el repo a $TARGET_BASHRC_D"

  mkdir -p "$TARGET_BASHRC_D"

  for file in "$REPO_BASHRC_D"/*.bash; do
    filename="$(basename "$file")"
    target="$TARGET_BASHRC_D/$filename"

    if [ -e "$target" ] && [ "$FORCE" = false ]; then
      echo "⚠️  $target ya existe. Usa --force para sobrescribir."
      continue
    fi

    if [ -L "$target" ] || [ -f "$target" ]; then
      rm -f "$target"
    fi

    ln -s "$file" "$target"
    echo "✅ $filename → $target"
  done
}

# === EJECUCIÓN ===
parse_args "$@"
backup_bashrc
ensure_loader_in_bashrc
create_symlinks

echo "🎉 Configuración completada. Abre un nuevo terminal para aplicar los cambios."
