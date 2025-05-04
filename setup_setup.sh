#!/bin/bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

COMMON_SCRIPT="$REPO_DIR/scripts/setup_commons.sh"
BASH_SCRIPT="$REPO_DIR/scripts/setup_bashrc.sh"
ZSH_SCRIPT="$REPO_DIR/scripts/setup_zshrc.sh"

show_menu() {
    echo "---------------------------------------------"
    echo "🔧 Portable-Setup: Herramientas de configuración"
    echo "---------------------------------------------"
    echo "1️⃣  Configurar commonrc.d (compartido)"
    echo "2️⃣  Configurar bashrc.d"
    echo "3️⃣  Configurar zshrc.d"
    echo "4️⃣  Instalar herramientas recomendadas"
    echo "5️⃣  Salir"
    echo "---------------------------------------------"
}

install_packages() {
    echo "🛠️ Instalando paquetes recomendados..."

    if command -v dnf >/dev/null 2>&1; then
        echo "📦 Detectado Fedora/RHEL (dnf)"
        sudo dnf install -y util-linux-user git bat fzf ripgrep fd-find tmux btop tldr git-delta lazygit zoxide
    elif command -v apt >/dev/null 2>&1; then
        echo "📦 Detectado Debian/Ubuntu (apt)"
        sudo apt update && sudo apt install -y util-linux git bat fzf ripgrep fd-find tmux btop tldr git-delta lazygit zoxide
    elif command -v pacman >/dev/null 2>&1; then
        echo "📦 Detectado Arch Linux (pacman)"
        sudo pacman -Syu util-linux git bat fzf ripgrep fd tmux btop tldr git-delta lazygit zoxide
    else
        echo "❌ No se detectó un gestor de paquetes compatible. Instala manualmente."
    fi
}

run_with_force_prompt() {
    local script_path=$1
    read -p "¿Quieres forzar (--force) la ejecución (sobrescribir symlinks)? (y/N): " FORCE_CHOICE
    if [[ "$FORCE_CHOICE" =~ ^[Yy]$ ]]; then
        bash "$script_path" --force
    else
        bash "$script_path"
    fi
}

# === LOOP PRINCIPAL ===

while true; do
    show_menu
    read -p "Selecciona una opción [1-5]: " choice

    case "$choice" in
        1)
            echo "🔧 Ejecutando setup_commons.sh..."
            run_with_force_prompt "$COMMON_SCRIPT"
            ;;
        2)
            echo "🔧 Ejecutando setup_bashrc.sh..."
            run_with_force_prompt "$BASH_SCRIPT"
            ;;
        3)
            echo "🔧 Ejecutando setup_zshrc.sh..."
            run_with_force_prompt "$ZSH_SCRIPT"
            ;;
        4)
            install_packages
            ;;
        5)
            echo "👋 Saliendo. ¡Hasta luego!"
            exit 0
            ;;
        *)
            echo "❌ Opción inválida. Intenta de nuevo."
            ;;
    esac

    echo "---------------------------------------------"
    read -p "Presiona Enter para volver al menú..."
done
