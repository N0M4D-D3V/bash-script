#!/bin/bash
# <>-< 4.0.0 >-<>
# <>-< N0M4D >-<>
#
# Para un mejor uso del script, sigue estos pasos:
#   > Otorga permisos de ejecución al script usando 'chmod +x ~/path-to-script/open-project.sh'
#   > Añade la carpeta donde almacenas los scripts al PATH agregando 'export PATH="path-to-scripts:$PATH"' en tu archivo .zshrc
#   > Incluye el siguiente alias en tu .zshrc: open(){ . open-project.sh } y refresca tu terminal
#   > Usa el comando 'open' para abrir el script sin parámetros.
#
# Uso
#   > open -> Lista los proyectos y pide al usuario que seleccione cuáles abrir.
#   > El usuario puede seleccionar un proyecto por su índice o varios separados por comas (ej: 1,3,5).
#

base_dir="$HOME/Documents/projects"

echo '<>---> PROJECT OPENER SCRIPT <---<>' 
echo ''

# Listar los directorios en el base_dir y numerarlos
echo " > Listing available directories:"
echo ''

projects=()
index=1

# Almacenar los directorios en un array y mostrarlos con un índice
while IFS= read -r -d '' dir; do
    dir_name=$(basename "$dir")
    projects+=("$dir")
    echo "    [$index] $dir_name"
    index=$((index+1))
done < <(find "$base_dir" -maxdepth 1 -type d -print0)

# Preguntar al usuario cuáles proyectos abrir
echo ''
read -p " > Introduce the project(s) index you want to open (use comma separator): " input

# Separar la entrada por comas y eliminar espacios
IFS=',' read -ra indices <<< "$input"

# Iterar sobre los índices proporcionados por el usuario
for i in "${indices[@]}"; do
    i=$(echo "$i" | xargs)  # Eliminar espacios en blanco
    if [[ "$i" =~ ^[0-9]+$ ]] && [ "$i" -ge 1 ] && [ "$i" -le "${#projects[@]}" ]; then
        project_dir="${projects[$((i-1))]}"
        echo " > Openning '$project_dir' ..."
        code "$project_dir"
    else
        echo " <!> Index '$i' not valid. Out of range or incorrect <!>"
    fi
done
