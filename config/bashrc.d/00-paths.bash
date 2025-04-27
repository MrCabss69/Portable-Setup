# ~/.bashrc.d/00-paths.bash
# Configuraciones de PATH específicas para Bash

# Las funciones prepend_to_path y append_to_path están definidas en commonrc.d/00-paths.sh

# Rutas específicas para Bash
prepend_to_path "/usr/local/texlive/2024/bin/x86_64-linux"
prepend_to_path "$HOME/Programas/Swift/usr/bin"

# Java (si prefieres configurarlo específicamente para Bash)
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk"
prepend_to_path "$JAVA_HOME/bin" 