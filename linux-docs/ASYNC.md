# Async

| Término Técnico                                 | Analogía (Fábrica de Pedidos)                       | Explicación / Rol                                                                                                  |
| :---------------------------------------------- | :-------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------- |
| **Microservicio / Servidor**                    | La **Fábrica completa**                             | La aplicación entera que recibe y procesa trabajo (pedidos).                                                      |
| **Proceso Maestro (Uvicorn / Gunicorn)** o **Load Balancer (Externo)** | El **Jefe de Planta / Supervisor General**          | **Coordina a nivel de fábrica:** Decide a qué Línea de Ensamblaje (Worker) va cada nuevo Pedido que entra. No se mete en *cómo* trabaja el Operario dentro de la línea, solo distribuye la carga inicial. |
| **Worker Process** (Uvicorn)                    | Una **Línea de Ensamblaje / Taller** individual     | Un proceso independiente dentro de la fábrica que maneja un conjunto de pedidos (para usar múltiples CPUs).         |
| **Event Loop (`asyncio`)**                      | El **Operario Experto** (uno por cada línea)        | Gestiona y ejecuta *muchos* pedidos (tareas) en *su* línea, cambiando rápidamente entre ellos.                      |
| **Tarea (`asyncio.Task`)**                      | Un **Pedido específico** (Pedido A, Pedido B...)    | Una unidad de trabajo individual (procesar una request) que el Operario maneja.                                     |
| **Peticiones Concurrentes**                     | **Muchos Pedidos** llegando/procesándose a la vez   | La fábrica (servidor) maneja múltiples solicitudes simultáneamente.                                               |
| **`await`**                                     | Operario **Espera** (pieza, pegamento...)           | La Tarea (Pedido) cede el control al Operario (Event Loop) porque necesita esperar por algo (red, disco).           |
| **Contexto (Execution Context)**                | La **Bandeja Específica** del Pedido A              | El estado y los datos asociados únicamente a la ejecución de *una* Tarea (Pedido) específica.                       |
| **`ContextVar`**                                | El **Compartimento/Hueco** en la Bandeja            | Una variable especial que guarda un valor diferente *para cada* Bandeja (Contexto) de Pedido.                       |
| **Correlation ID (`X-Request-ID`)**             | La **Etiqueta de Seguimiento Única** en la Bandeja   | El identificador único (ej: "abc-123") para un Pedido completo, que viaja con él.                              |
| **Middleware (`CorrelationIdMiddleware`)**        | El **Recepcionista/Control de Calidad** (en la línea) | Código que intercepta cada Pedido al entrar/salir *de la línea*. Lee/crea la Etiqueta y la pone/quita de la Bandeja. |
| **`ContextVar.set()`**                          | **Poner/Escribir** la Etiqueta en la Bandeja        | Asocia un valor (el ID) a la variable (`ContextVar`) *solo* para la Bandeja (Contexto) actual.                   |
| **`ContextVar.get()` (`get_correlation_id()`)** | **Leer** la Etiqueta de la Bandeja actual           | Obtiene el valor de la variable (`ContextVar`) que corresponde a la Bandeja (Contexto) activa en ese momento.      |
| **`ContextVar.reset()`**                        | **Quitar** la Etiqueta / Guardar la Bandeja       | Limpia el valor de la variable (`ContextVar`) para el contexto actual, restaurándolo a su estado anterior.   |


**En esencia:**

El **Operario (Event Loop)** en cada **Línea (Worker)** maneja múltiples **Pedidos (Tasks)** concurrentemente. Cuando trabaja en un Pedido, usa su **Bandeja (Contexto)** específica. Dentro de la bandeja hay un **Compartimento (`ContextVar`)** con la **Etiqueta de Seguimiento (Correlation ID)** única de ese pedido. El **Recepcionista (Middleware)** se asegura de que cada pedido tenga su etiqueta al entrar y salir. Cualquier herramienta (logger, cliente HTTP) puede **Leer (`.get()`)** la etiqueta de la bandeja que el operario tiene delante en ese momento para saber a qué pedido pertenece el trabajo actual.


**Aclaración del Jefe de Planta / Supervisor General:**

*   Cuando ejecutas `uvicorn main:app --workers 4`, se lanza un **proceso maestro** (el Supervisor General).
*   Este proceso maestro **NO** ejecuta el código de tu aplicación FastAPI directamente.
*   Su trabajo principal es:
    1.  Abrir el puerto de red (ej: 8000) para escuchar conexiones entrantes.
    2.  Lanzar y supervisar los **procesos trabajadores** (los 4 workers / Líneas de Ensamblaje). Si uno se cae, intenta levantarlo de nuevo.
    3.  Aceptar las conexiones TCP entrantes y **distribuirlas** a uno de los workers disponibles (usando mecanismos del sistema operativo, como `SO_REUSEPORT`, o pasando descriptores de fichero).
*   Una vez que un worker recibe la conexión, *ese* worker (con su Operario/Event Loop) se encarga de manejar la petición HTTP completa.
*   Si usas un balanceador de carga externo (como Nginx, HAProxy, o uno de la nube), ese balanceador hace el papel del Supervisor General distribuyendo las requests entre las diferentes instancias (contenedores/VMs) de tu aplicación.