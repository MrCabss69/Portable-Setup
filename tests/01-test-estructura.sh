#!/bin/bash

echo "🔍 Test: Estructura base de Portable-Setup"

CHECKS=(
    "config/bashrc.d/00-paths.bash"
    "config/commonrc.d/load_common.sh"
    "config/zshrc.d/00-core.zsh"
    "cron.d/osint.cron"
    "services.d/jupyter.service"
    "config/repo-templates/python/README.md"
    "init_repo.sh"
)

for path in "${CHECKS[@]}"; do
    if [ ! -e "$path" ]; then
        echo "❌ Falta: $path"
        exit 1
    else
        echo "✅ OK: $path"
    fi
done

echo "✅ Estructura verificada."
