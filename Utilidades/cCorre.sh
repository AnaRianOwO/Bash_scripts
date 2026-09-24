#!/bin/bash

HISTORY="$HOME/.config/cCorreHistorial.conf"
mkdir -p "$(dirname "$HISTORY")"

ejecC(){
  ejecutable="/tmp/$(basename "$1" .c)_$(date +%s)"
      
  if ! gcc "$1" -o "$ejecutable" -lm 2>/dev/null; then
    echo "Error al compilar"
    return 1
  fi
      
  echo "Ejecutando: $ejecutable"
  "$ejecutable"
}

ejecMakefile(){
  ejecutable="/tmp/proyecto_$(date +%s)"
  
  if ! make 2>/dev/null; then
    echo "Error al compilar"
    return 1
  fi
  
  cp calculadora "$ejecutable"
  
  echo "Ejecutando: $ejecutable"
  "$ejecutable"
}

nuevo(){
  read -p "Ingresa la ruta completa del archivo .c uwu:" archivo
  if [[ ! -e "$archivo" ]]; then
    echo "No es una ruta correcta, intenta de nueva"
    return 1
  fi

  echo "$archivo" >> "$HISTORY"
  
  ejecC $archivo
}

antiguo(){
  if [[ ! -f "$HISTORY" ]]; then
    echo "No hay historial aún"
    return 1
  fi
  
  echo "--- Historial de archivos compilados ---"
  nl "$HISTORY"
  echo "----------------------------------------"
  read -p "Ingresa la línea donde está el archivo para volver a compilar" linea

  if [[ ! "$linea" =~ ^[0-9]+$ ]]; then
    echo "Debes ingresar un número válido"
    return 1
  fi

  archivo=$(sed -n "${linea}p" "$HISTORY")

  if [[ -z "$archivo" ]]; then
    echo "Número de línea inválido"
    return 1
  fi
    
  if [[ ! -e "$archivo" ]]; then
    echo "El archivo ya no existe en esa ruta"
    return 1
  fi

  echo "Compilando nuevamente: $archivo"
  ejecC $archivo
}

touch "$HISTORY"

case "$1" in
    "nuevo" | "new")
         nuevo;;
    "antiguo" | "anterior" | "last")
        antiguo;;
    "make" | "makefile")
    	ejecMakefile;;
    *)
      echo "Uso: $0 {nuevo|new|antiguo|anterior|last}"
      echo "  nuevo/new     - Compilar y ejecutar un nuevo archivo .c"
      echo "  antiguo/anterior/last - Recompilar un archivo del historial"
      exit 1;;
esac



