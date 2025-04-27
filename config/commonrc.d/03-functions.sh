# ~/.commonrc.d/03-functions.sh

# Lanza Cursor (editor de código) en segundo plano
cursor() {
  # Intenta usar la versión AppImage si existe
  if [ -f "$HOME/Programas/cursor.AppImage" ]; then
    ("$HOME/Programas/cursor.AppImage" "$@" >/dev/null 2>&1 &)
    disown
    return
  fi
  
  # Intenta usar la versión instalada en .local
  if [ -f "$HOME/.local/apps/cursor/Cursor.sh" ]; then
    ("$HOME/.local/apps/cursor/Cursor.sh" "$@" >/dev/null 2>&1 &)
    disown
    return
  fi
  
  # Si llegamos aquí, no encontramos Cursor
  echo "❌ Cursor no encontrado. Instálalo en ~/Programas/cursor.AppImage o ~/.local/apps/cursor/"
}

# Limpia terminal y scrollback
cl() {
  clear && printf '\e[3J'  # Limpia también scrollback
}

# Crear un directorio y entrar a él
mkcd() {
  mkdir -p "$1" && cd "$1"
}
