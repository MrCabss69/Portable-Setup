# ~/.commonrc.d/load_common.sh
COMMON_DIR="$HOME/.commonrc.d"
LOADER_FILE="$COMMON_DIR/load_common.sh"

if [ -d "$COMMON_DIR" ]; then
  for file in "$COMMON_DIR"/*.sh; do
    # Evita recursión infinita
    [ "$file" = "$LOADER_FILE" ] && continue
    [ -f "$file" ] && . "$file"
  done
fi
