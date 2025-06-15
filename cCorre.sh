#!/bin/bash

read -p "Ingresa la ruta completa del archivo .c uwu:" archivo

ejecutable="/tmp/$(basename "$archivo" .c)_$(date +%s)"
gcc "$archivo" -o "$ejecutable" -lm

echo "Ejecutando el archivo $(ejecutable)..."
"$ejecutable"

