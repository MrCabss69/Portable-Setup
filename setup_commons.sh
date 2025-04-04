#!/bin/bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_COMMON_DIR="$REPO_DIR/.commonrc.d"
TARGET_COMMON_DIR="$HOME/.commonrc.d"
FORCE=false

BASHRC="$HOME/.bashrc"
ZSHRC="$HOME/.zshrc"
BASHRC_BACKUP="$BASHRC.backup.$(date +%s)"
ZSHRC_BACKUP="$ZSHRC.backup.$(date +%s)"

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

backup_files() {
  echo "📦 Backup de .bashrc → $BASHRC_BACKUP"
  cp "$BASHRC" "$BASHRC_BACKUP"

  echo "📦 Backup de .zshrc → $ZSHRC_BACKUP"
  cp "$ZSHRC" "$ZSHRC_BACKUP"
}

ensure_loader_in_file() {
  local shell_rc=$1
  if ! grep -q 'commonrc\.d/load_common.sh' "$shell_rc"; then
    echo "➕ Insertando loader en $shell_rc"
    cat <<'EOF' >> "$shell_rc"

# Load shared configs
[ -f "$HOME/.commonrc.d/load_common.sh" ] && . "$HOME/.commonrc.d/load_common.sh"
EOF
  else
    echo "✅ Loader ya presente en $shell_rc"
  fi
}

create_symlinks() {
  echo "🔗 Creando symlinks en $TARGET_COMMON_DIR"
  mkdir -p "$TARGET_COMMON_DIR"

  for file in "$REPO_COMMON_DIR"/*.sh; do
    fname=$(basename "$file")
    target="$TARGET_COMMON_DIR/$fname"

    if [ -e "$target" ] && [ "$FORCE" = false ]; then
      echo "⚠️  $target ya existe. Usa --force para sobrescribir."
      continue
    fi

    [ -e "$target" ] && rm -f "$target"
    ln -s "$file" "$target"
    echo "✅ $fname → $target"
  done
}

# === MAIN ===
parse_args "$@"
backup_files
ensure_loader_in_file "$BASHRC"
ensure_loader_in_file "$ZSHRC"
create_symlinks

echo "🎉 commonrc.d configurado correctamente. Reinicia tu terminal para aplicar los cambios."
