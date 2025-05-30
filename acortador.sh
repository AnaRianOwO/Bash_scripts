#!/bin/bash

esComandOwO() {
  [[ "$1" == *" "* ]]
}
# El código funciona con cowsay, si no se desea, cambiar la línea  por echo
if ! command -v cowsay &> /dev/null; then
    echo "Instalando cowsay para diversión máxima..."
    sudo apt install cowsay -y
fi

read -p "Ingresa la ruta completa al script, o, el script que desea poner alias (ej: /home/owo/mis-scripts/script.sh o sudo apt update): " rutaScript
read -p "Ingresa el alias para el script (ej: 'actualizar'): " aliasNombre

if ! esComandOwO "$rutaScript" && [ ! -f "$rutaScript" ]; then
    echo "Error: El archivo '$rutaScript' no existe. ¿Quieres que sea un comando? Usa comillas."
    exit 1
fi

if [[ "$rutaScript" == *.c ]]; then
  binario="${rutaScript%.*}"
  gcc "$rutaScript" -o "$binario" || { echo "Error compilando el .c unu"; exit 1; }
  rutaScript="$binario"
fi

if ! esComandOwO "$rutaScript"; then
    mkdir -p ~/.local/bin
    nombre_script=$(basename "$rutaScript")
    cp "$rutaScript" ~/.local/bin/ || { echo "Error copiando el script"; exit 1; }
    chmod +x ~/.local/bin/"$nombre_script"
    aliasCMD="~/.local/bin/$nombre_script"
else
    aliasCMD="$rutaScript"  # Es un comando directo (ej: "sudo apt update")
fi

echo "alias $aliasNombre=\"$aliasCMD\"" >> ~/.bashrc

cowsay "¡Licto, amiguito!, ahora puedes usar '$aliasNombre' para ejecutar tu script. Recargando la terminal ahora mismo..."
source ~/.bashrc
