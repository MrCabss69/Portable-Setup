#!/bin/bash

# 🚀 Inicializador de proyectos OSS desde la plantilla Python

TEMPLATE_PATH="config/repo-templates/python"
DEFAULT_LICENSE="MIT"

echo "---------------------------------------------"
echo "🔧 Inicializador de proyecto OSS"
echo "---------------------------------------------"

# 1️⃣ Pedir datos al usuario
read -p "Nombre del nuevo proyecto: " PROJECT_NAME
read -p "Ruta de destino (por defecto ./<project_name>): " DEST_PATH
read -p "Autor (por defecto $(whoami)): " AUTHOR
read -p "Año (por defecto $(date +%Y)): " YEAR

# Usar valores por defecto si vacío
DEST_PATH=${DEST_PATH:-"./$PROJECT_NAME"}
AUTHOR=${AUTHOR:-$(whoami)}
YEAR=${YEAR:-$(date +%Y)}

echo "📁 Creando proyecto '$PROJECT_NAME' en '$DEST_PATH'..."
echo "👤 Autor: $AUTHOR | Año: $YEAR"

# 2️⃣ Verificar existencia
if [ -d "$DEST_PATH" ]; then
    echo "⚠️ La carpeta destino ya existe. ¿Deseas continuar y sobreescribir algunos archivos? (y/N)"
    read -r CONFIRM
    if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
        echo "🚫 Cancelado."
        exit 1
    fi
else
    mkdir -p "$DEST_PATH"
fi

# 3️⃣ Copiar plantilla
echo "📦 Copiando estructura..."
cp -r "$TEMPLATE_PATH/"* "$DEST_PATH/"

# 4️⃣ Reemplazar placeholders
echo "✍️ Personalizando archivos..."
for file in $(grep -rl "{project_name}\|{author}\|{year}" "$DEST_PATH"); do
    sed -i "s/{project_name}/$PROJECT_NAME/g" "$file"
    sed -i "s/{author}/$AUTHOR/g" "$file"
    sed -i "s/{year}/$YEAR/g" "$file"
done

# 5️⃣ Crear carpetas extra si es necesario
mkdir -p "$DEST_PATH/src/$PROJECT_NAME"
touch "$DEST_PATH/src/$PROJECT_NAME/__init__.py"

echo "✅ Proyecto inicializado correctamente."

# 6️⃣ Opcional: inicializar git
read -p "¿Deseas inicializar un repositorio Git? (y/N): " GIT_INIT
if [[ "$GIT_INIT" =~ ^[Yy]$ ]]; then
    cd "$DEST_PATH" || exit
    git init
    git add .
    git commit -m "🚀 Estructura inicial basada en plantilla OSS"
    echo "✔️ Repositorio Git inicializado y primer commit creado."
fi

echo "🚀 Listo. Puedes empezar a trabajar en '$DEST_PATH'."
