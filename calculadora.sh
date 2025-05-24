#!/bin/bash

#Configuración owowowowo
historial_file="$HOME/.calc_history"
memoria=0

#Función con un solo número
unoSolo() {
  echo "Toncei un número uwu, ¿Qué hacemos con ese número?"
  select opcion in "Potencia (x^2)" "Raíz cuadrada" "Seno" "Coseno" "Tangente" "Logaritmo natural" "Salir"; do
    case $opcion in
      "Potencia (x^2)") echo "$1^2" | bc ; break ;;
      "Raíz cuadrada") echo "scale=2; sqrt($1)" | bc -l ; break ;;
      "Seno") echo "s($1)" | bc -l ; break ;;
      "Coseno") echo "c($1)" | bc -l ; break ;;
      "Tangente") echo "s($1)/c($1)" | bc -l ; break ;;
      "Logaritmo natural") echo "l($1)" | bc -l ; break ;;
      "Salir") exit 0 ;;
      *) echo "Oye no >:c, esa opción no estaba"
    esac
  done
}

#Función con dos o más números
multiples() {
  echo "Waos, entonces, trabajamos con $# números: $@ ¿Qué hacemos con esos números?"
  select opcion in "Sumar" "Restar" "Multiplicar" "Dividir" "Promedio" "Salir"; do
    case $opcion in
      "Sumar")
        suma=0
        for num in "$@"; do
          suma=$(echo "$suma + $num" | bc)
        done
        echo "Resultado: $suma" ; break ;;
      "Restar")
        res=$1
        shift
        for num in "$@"; do
          res=$(echo "$res - $num" | bc)
        done
        echo "Resultado: $res" ; break ;;
      "Multiplicar")
        multi=1
        for num in "$@"; do
          multi=$(echo "$multi * $num" | bc)
        done
        echo "Resultado: $multi" ; break ;;
      "Dividir")
        div=$1
        shift
        for num in "$@"; do
          div=$(echo "scale=2; $div / $num" | bc)
        done
        echo "Resultado: $div" ; break ;;
      "Promedio")
        suma=0
        for num in "$@"; do
          suma=$(echo "$suma + $num" | bc)
        done
        avg=$(echo "scale=2; $suma / $#" | bc)
        echo "Promedio: $avg" ; break ;;
      "Salir") exit 0 ;;
        *) echo "que no unu, esa opción no está >:c" ;;
      esac
    done
}

if [ $# -eq 0 ]; then
  echo "Oye pero ponele un número bestie"

elif [ $# -eq 1 ]; then
  unoSolo $1
else
  multiples "$@"
fi
