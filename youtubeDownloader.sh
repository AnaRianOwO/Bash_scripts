#!/bin/bash

# Configuración
source $HOME/Mis_proyectos/Bash_scripts/config.sh

archivo="/home/pilar/Documents/TXT/songs uwu.txt"
#formato="bestaudio/best"
extension="mp3"
carpetaDescargas="~/Music"
Shh="--quiet --no-warnings"

while IFS= read -r linea; do
  if [[ -z "$linea" ]]; then
    continue
  fi

  echo "Buscando: '$linea' "

  titulo=$(yt-dlp --cookies "$YT_COOKIES" $Shh --print title --default-search "ytsearch" "$linea")
  
  yt-dlp --cookies "$YT_COOKIES" $Shh \
    --extract-audio \    
    --audio-format "$extension" \
#    --format "$formato" \
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
