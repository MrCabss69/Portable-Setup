# ~/.commonrc.d/00-paths.sh

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

# Programas y herramientas comunes
append_to_path "/opt/platform-tools"
append_to_path "$HOME/.composer/vendor/bin"

# LD_LIBRARY_PATH común
export LD_LIBRARY_PATH="/usr/lib64"

export PATH

# Variables de entorno comunes
export LESSHISTFILE=-
export WGETRC=/dev/null 