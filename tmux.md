# **Tmux Cheatsheet (Guía Rápida)**

**Conceptos Clave:**

*   **Sesión (Session):** Un contenedor principal para un conjunto de ventanas. Puedes tener múltiples sesiones ejecutándose simultáneamente. Puedes "desadjuntarte" (detach) de una sesión y dejarla corriendo en segundo plano, y luego "adjuntarte" (attach) de nuevo.
*   **Ventana (Window):** Similar a una pestaña en un navegador o terminal. Cada ventana ocupa toda la pantalla y puede contener uno o más paneles.
*   **Panel (Pane):** Una división dentro de una ventana. Puedes dividir una ventana en múltiples paneles, cada uno ejecutando su propio shell o comando.
*   **Prefijo (Prefix):** La combinación de teclas que debes presionar *antes* de la mayoría de los comandos de `tmux`. **Por defecto es `Ctrl+b`**. (Se presiona `Ctrl+b`, se sueltan ambas teclas, y luego se presiona la tecla del comando).

**Comandos (Fuera de Tmux - en tu shell normal):**

*   `tmux new` o `tmux new-session`: Inicia una nueva sesión de tmux.
*   `tmux new -s <nombre_sesion>`: Inicia una nueva sesión con un nombre específico.
*   `tmux ls` o `tmux list-sessions`: Lista las sesiones de tmux activas.
*   `tmux a` o `tmux attach`: Se adjunta a la última sesión activa.
*   `tmux a -t <nombre_sesion_o_numero>`: Se adjunta a una sesión específica por nombre o número.
*   `tmux kill-session -t <nombre_sesion_o_numero>`: Mata (termina) una sesión específica.
*   `tmux kill-server`: Mata todas las sesiones y el servidor tmux. ¡Cuidado!

**Comandos (Dentro de Tmux - después de presionar `Prefijo` (`Ctrl+b` por defecto)):**

**Sesiones:**

*   `d`: **D**esadjuntar la sesión actual (la sesión sigue corriendo en segundo plano).
*   `s`: Listar **s**esiones interactivamente (puedes cambiar entre ellas).
*   `$`: Renombrar la **s**esión actual.

**Ventanas (Windows):**

*   `c`: **C**rear una nueva ventana.
*   `w`: Listar **w**indows (ventanas) interactivamente (puedes cambiar entre ellas).
*   `,`: Renombrar la ventana actual.
*   `n`: Ir a la ventana **n**ext (siguiente).
*   `p`: Ir a la ventana **p**revious (anterior).
*   `l`: Ir a la ú**l**tima ventana activa.
*   `0`...`9`: Ir a la ventana por su número (0 a 9).
*   `&`: Cerrar (matar) la ventana actual (pide confirmación).
*   `f`: Buscar texto en las ventanas (**f**ind).

**Paneles (Panes):**

*   `%`: Dividir el panel actual **v**erticalmente (izquierda/derecha). (Piensa en el `%` como una línea vertical).
*   `"`: Dividir el panel actual **h**orizontalmente (arriba/abajo). (Piensa en `"` como dos líneas horizontales).
*   `x`: Cerrar (matar) el panel actual (pide confirmación).
*   `z`: Hacer **z**oom/maximizar el panel actual. Presiona de nuevo para restaurar.
*   `o`: Ir al panel siguiente (en orden numérico).
*   `;`: Ir al panel anterior (último activo).
*   `q`: Mostrar los números de los paneles brevemente.
*   `{`: Intercambiar el panel actual con el anterior.
*   `}`: Intercambiar el panel actual con el siguiente.
*   `Espacio`: Cambiar entre los layouts de paneles predefinidos.
*   `Flecha Arriba ↑`: Ir al panel de arriba.
*   `Flecha Abajo ↓`: Ir al panel de abajo.
*   `Flecha Izquierda ←`: Ir al panel de la izquierda.
*   `Flecha Derecha →`: Ir al panel de la derecha.
*   *(Avanzado - Redimensionar)*: Mantén presionado `Prefijo` y usa las flechas (`Ctrl+b` + `Flecha`) o usa `Prefijo` + `:` para entrar al modo comando y escribe `resize-pane -D/U/L/R <numero_celdas>`, por ejemplo `resize-pane -D 5` para agrandar hacia abajo 5 celdas.

**Copiar y Pegar (Modo Copia):**

*   `[`: Entrar en modo **c**opia (Copy Mode). Te permite moverte por el historial (scrollback) y seleccionar texto.
    *   Usa las flechas, `PageUp`, `PageDown` para navegar.
    *   Estilo Vi (a menudo por defecto):
        *   `Espacio` para iniciar selección.
        *   Mueve el cursor para seleccionar.
        *   `Enter` para copiar la selección y salir del modo copia.
    *   Estilo Emacs:
        *   `Ctrl+Espacio` para iniciar selección.
        *   Mueve el cursor para seleccionar.
        *   `Alt+w` (o `Meta+w`) para copiar la selección y salir del modo copia.
    *   `q`: Salir del modo copia sin copiar.
*   `]`: **P**egar el contenido del buffer de tmux (lo último que copiaste con `Enter` o `Alt+w`).

**Otros Comandos Útiles:**

*   `t`: Mostrar un reloj grande en el panel actual.
*   `:`: Entrar en el modo **c**omando de tmux (similar a Vim). Puedes escribir comandos largos aquí.
*   `?`: Mostrar la lista de todos los atajos de teclado definidos.

**Nota Importante:**

*   Recuerda siempre presionar tu **Prefijo** (`Ctrl+b` por defecto), soltarlo, y *luego* presionar la tecla del comando deseado.

**Personalización:**

*   Puedes personalizar `tmux` (cambiar el prefijo, añadir atajos, cambiar colores, etc.) editando el archivo `~/.tmux.conf`.
