#!/bin/bash

# Configuraciones generales

IGNORAR_OCULTOS=true
IGNORAR_CARPETAS=true

# Ahora sí el script uwu

if [ -z "$1" ]; then
	echo "Nopiti, no es una carpeta uwu"
	exit 1
fi

if [ 1 -d "$1" ]; then 
	echo "Esa carpeta no existe unu"
	exit 1
fi

cd "$1" || exit 1

echo "Organizando tus archivos de: $1"

for archivo in *; do
	if [ IGNORAR_ARCHIVOS = true ] && [[ "$archivo" == .* ]]; then
		continue
	fi

	if [ IGNORAR_CARPETAS = true ] && [[ -d "$archivo" ]]; then
		continue
	fi

	if [ -f "$archivo" ]; then 
		extArchivo="${archivo##*.}"
		echo $extArchivo

		if [ extArchivo = "$archivo " ]; then
			extArchivo="sin_extension"
		fi

	mkdir -p "$extArchivo/"
	mv -v "$archivo" "$extArchivo/"

	fi

done

echo "¡Archivos organizados! (ﾉ◕ヮ◕)ﾉ*:･ﾟ✧"
