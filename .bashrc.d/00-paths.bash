# ~/.bashrc.d/00-paths.bash

# Funciones para manejo seguro del PATH
prepend_to_path() {
  case ":$PATH:" in
    *":$1:"*) ;;  # Ya está presente
    *) PATH="$1:$PATH" ;;
  esac
}

append_to_path() {
  case ":$PATH:" in
    *":$1:"*) ;;
    *) PATH="$PATH:$1" ;;
  esac
}

# PATH de usuario
prepend_to_path "$HOME/.local/bin"
prepend_to_path "$HOME/bin"

# Programas y herramientas
prepend_to_path "/usr/local/texlive/2024/bin/x86_64-linux"
prepend_to_path "$HOME/Programas/Swift/usr/bin"
append_to_path "/opt/platform-tools"
append_to_path "$HOME/.composer/vendor/bin"

# Java
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk"
prepend_to_path "$JAVA_HOME/bin"

# LD_LIBRARY_PATH
export LD_LIBRARY_PATH="/usr/lib64"

export PATH


export LESSHISTFILE=-
export WGETRC=/dev/null
