#!/bin/bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ZSHRC_D="$REPO_DIR/.zshrc.d"
TARGET_ZSHRC="$HOME/.zshrc"
TARGET_ZSHRC_D="$HOME/.zshrc.d"
BACKUP="$HOME/.zshrc.backup.$(date +%s)"
FORCE=false

print_usage() {
  echo "Uso: $0 [--force]"
  echo "  --force   Reemplaza symlinks existentes"
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

backup_zshrc() {
  echo "📦 Backup de .zshrc actual → $BACKUP"
  cp "$TARGET_ZSHRC" "$BACKUP"
}

ensure_loader_in_zshrc() {
  if ! grep -q '.zshrc\.d/' "$TARGET_ZSHRC"; then
    echo "➕ Insertando loader modular en $TARGET_ZSHRC"
    cat <<'EOF' >> "$TARGET_ZSHRC"

# Carga modular desde ~/.zshrc.d
if [ -d "$HOME/.zshrc.d" ]; then
  for file in "$HOME/.zshrc.d/"*.zsh; do
    [ -f "$file" ] && source "$file"
  done
fi
EOF
  else
    echo "✅ Loader ya presente en $TARGET_ZSHRC"
  fi
}

create_symlinks() {
  echo "🔗 Creando symlinks en $TARGET_ZSHRC_D"
  mkdir -p "$TARGET_ZSHRC_D"

  for file in "$REPO_ZSHRC_D"/*.zsh; do
    fname=$(basename "$file")
    target="$TARGET_ZSHRC_D/$fname"

    if [ -e "$target" ] && [ "$FORCE" = false ]; then
      echo "⚠️  $target ya existe. Usa --force para reemplazar."
      continue
    fi

    [ -e "$target" ] && rm -f "$target"
    ln -s "$file" "$target"
    echo "✅ $fname → $target"
  done
}

# === MAIN ===
parse_args "$@"
backup_zshrc
ensure_loader_in_zshrc
create_symlinks

echo "🎉 Zsh configurado correctamente. Abre un nuevo terminal para aplicar los cambios."
