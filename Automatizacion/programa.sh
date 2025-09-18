#!/bin/bash

CONFIG_FILE="$HOME/.config/project_launcher.conf"
aliasName="$1"
projectPath="$2"

iniciarProyecto() {
  local aliasName="$1"
  local projectPath=$(grep "^$aliasName=" "$CONFIG_FILE" | cut -d'=' -f2-)

  if [ -z "$projectPath" ]; then
    echo "Error: Alias '$aliasName' no encontrado unu"
    echo "Usa agregar $aliasName /ruta/al/proyecto para crearlo"
    exit 1
  fi

  echo "Iniciando proyecto $aliasName en $projectPath"

  tmux new-session -d -s "$aliasName" -c "$projectPath"
  tmux split-window -v -p 50 -c "$projectPath"

  tmux send-keys -t "$aliasName":0.1 "autopull" C-m
  tmux send-keys -t "$aliasName":0.1 "ls" C-m
  tmux attach-session -t "$aliasName"
}

agregarAlias() {
  local aliasName="$2"
  local projectPath="$3"
  if [ -z "$aliasName" ] || [ -z "$projectPath" ]; then
    echo "Error: Se usa: $0 agregar alias ruta"
    exit 1
  fi

  if grep -q "^$aliasName=" "$CONFIG_FILE"; then
    echo "Advertencia: el alias '$alias' ya existe, sobreescribiendo..."
    sed -i "/^$aliasName=/d" "$CONFIG_FILE"
  fi

  echo "$aliasName=$projectPath" >> "$CONFIG_FILE"
  echo "Éxito: el alias '$aliasName' se ha agregado para la ruta de '$projectPath'"
}

mostrarRuta() {
  local aliasName="$2"
  if [ -z "$aliasName"  ]; then
    echo "Alias no encontrado"
    exit 1
  fi

  local projectPath=$(grep "^$aliasName=" "$CONFIG_FILE" | cut -d'=' -f2- | tr -d '\n')
  echo "$projectPath" | xclip -selection clipboard
  echo "Copiado al portapapeles exitosamente uwu"
}

cerrarProyecto() {
  local sesion=$(tmux display-message -p '#S')
  tmux send-keys -t "$sesion":0.1 "autopush && exit" C-m
  sleep 3
  while tmux list-windows -t "$sesion" | grep -q "0.1"; do
    sleep 5 
  done
  tmux kill-session -t "$sesion"
  echo "¡Sesión '$sesion' cerrada!"
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
        agregarAlias "$@";;
    "pwd")
        mostrarRuta "$@";;
    "cerrar"|"close"|"finalizar")
        cerrarProyecto;;
    "ayuda"|"help"|"--help"|"-h"|"")
        ayuda;;
    *)
        iniciarProyecto "$1";;
esac
