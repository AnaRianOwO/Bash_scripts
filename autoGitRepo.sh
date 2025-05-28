#!/bin/bash

if [ -z "$1" ]; then
    repoPath="."
    echo "No se especificó carpeta, bestie. Usando el repositorio actual uwu..."
else
    repoPath="$1"
fi


cd "$repoPath" || { echo "Error: Carpeta no encontrada unu"; exit 1; }

if [ ! -d ".git" ]; then
  echo "No es un repositorio unu"
  exit 1
fi

git add *
echo "Estos son los cambios que se agregan al repositorio"
git status
ramaActual=$(git branch --show-current)
echo "Estás en esta rama: $ramaActual"

read -p "Escribe el mensaje para el commit uwu: " commitMsg
read -p "¿Quieres hacer commir en la rama '$ramaActual' (Y/n)?" confirmarRama

if [[ "$confirmarRama" =~ ^[Nn]$ ]]; then
  read -p "¿A qué rama nos pasamos bestie?" ramaNueva
  git checkout "$ramaNueva" 2>/dev/null || git checkout -b "$ramaNueva"
  ramaActual="$ramaNueva"
fi

 git commit -m "$commitMsg"

read -p "Atención, vas a hacer push en '$ramaActual', ¿confirmas? (Y/n)" confirmaPush
if [[ ! "$confirmaPush" =~ ^[Nn]$ ]]; then
  git push origin "$ramaActual"
  echo "Por el poder que me concedio la terminal, has subido a Github uwu"
else
  echo "Pipipipi, bueno, falta el push no más uwu"
fi
