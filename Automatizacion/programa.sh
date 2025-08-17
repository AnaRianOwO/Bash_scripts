#!/bin/bash

CONFIG_FILE="$HOME/.config/project_launcher.conf"

iniciarProyecto() {
  local alias="$1"
  local projectPath=$(grep "^$alias=" "$CONFIG_FILE" | cut -d'=' -f2-)

  if [ -z "projectPath" ]; then
    echo "Error: Alias '$alias' no encontrado unu"
    echo "Usa agregar $alias /ruta/al/proyecto para crearlo"
    exit 1
  fi

  echo "Iniciando proyecto $alias en $projectPath"

  tmux new-session -d -s "$alias" -c "$projectPath"
  tmux split-window -v -p 50 -c "$projectPath"

  tmux send-keys -t "$alias":0.1 "tree" C-m
  tmux attach-session -t "$alias"
}

agregarAlias() {
  local alias="$1"
  local projectPath="$2"

  if [ -z "$alias" ] || [ -z "$projectPath" ]; then
    echo "Error: Se usa: $0 agregar alias ruta"
    exit 1
  fi

  if grep -q "^$alias_name=" "$CONFIG_FILE"; then
    echo "Advertencia: el alias '$alias' ya existe, sobreescribiendo..."
    sed -i "/^$alias_name=/d" "$CONFIG_FILE"
  fi

  echo "$alias=$projectPath" >> "$CONFIG_FILE"
  echo "Éxito: el alias '$alias' se ha agregado para la ruta de '$projectPath'"
}

mostrarRuta() {
  local alias="$1"

  if [ -z "$alias"  ]; then
    echo "Alias no encontrado"
    exit 1
  fi

  local projectPath=$(grep "^$alias=" "$CONFIG_FILE" | cut -d'=' -f2- | tr -d '\n')
  echo "$projectPath" | xclip -selection clipboard
  echo "Copiado al portapapeles exitosamente uwu"
}

ayuda() {
  echo "Uso:"
  echo "  $0 [ALIAS]              # Iniciar proyecto"
  echo "  $0 agregar ALIAS RUTA  # Agregar nuevo proyecto"
  echo "  $0 ayuda               # Mostrar esta ayuda"
  echo "Ejemplos:"
  echo "  $0 mi_proyecto"
  echo "  $0 agregar mi_proyecto ~/dev/mi_proyecto"
}

touch "$CONFIG_FILE"

case "$1" in
    "agregar"|"add"|"añadir")
        agregarAlias "$2" "$3";;
    "ayuda"|"help"|"--help"|"-h")
        ayuda;;
    "")
        ayuda;;
    "pwd")
        mostrarRuta "$2";;
    *)
        iniciarProyecto "$1";;
      
esac
