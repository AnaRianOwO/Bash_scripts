#!/bin/bash

# Configuración

archivo="/home/pilar/Documents/TXT/songs uwu.txt"
formato="bestaudio/best"
extension="mp3"
carpetaDescargas="~/Music"

while IFS= read -r linea; do
  if [[ -z "$linea" ]]; then
    continue
  fi

  echo "Buscando: '$linea' "

  titulo=$(yt-dlp --print title --default-search "ytsearch" "$linea")
  
  yt-dlp \
    --extract-audio \
    --audio-format "$extension" \
    --format "$formato" \
    --output "$carpetaDescargas/%(title)s.%(ext)s" \
    --default-search "ytsearch" \
    "$linea"

  if [ $? -eq 0 ]; then
    echo "Descargado: '$titulo'"
  else
    echo "Error al descargar: '$linea'"
  fi

done < "$archivo"

echo "¡Descarga completa! Revisa la carpeta '$carpetaDescargas'"
