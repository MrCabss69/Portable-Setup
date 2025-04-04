# ~/.commonsrc.d/03-functions.sh

cursor() {
  (
    "$HOME/Programas/cursor.AppImage" "$@" >/dev/null 2>&1 &
    disown
  ) >/dev/null 2>&1
}

cl() {
  clear && printf '\e[3J'  # Limpia también scrollback
}
