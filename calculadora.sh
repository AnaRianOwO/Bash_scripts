#!/bin/bash

#Configuración
guardarHistorial() {
    echo "$1 => $2 = $3" >> ~/.calc_history
}

# MCM y MCD

mcm() {
  local a=$1
  local b=$2
  local mcd=$(mcd $a $b)
  echo $(( (a*b)/mcd ))
}

mcd() {
  local a=$1
  local b=$2
  if (( b == 0 )); then
    echo $a
  else
    mcd $b $((a % b))
  fi
}

#Función con un solo número
unoSolo() {
  echo "Toncei un número uwu, ¿Qué hacemos con ese número?"
  select opcion in "Potencia (x^2)" "Raíz cuadrada" "Seno" "Coseno" "Tangente" "Logaritmo natural" "Exponencial" "Múltiplo de 3" "Sumar hasta" "Sumar cuadrados hasta" "Sumar cubos hasta" "Fibonacci hasta" "Salir"; do
    case $opcion in
      "Potencia (x^2)") echo "$1^2" | bc; break ;;
      "Raíz cuadrada") echo "scale=2; sqrt($1)" | bc -l ; break ;;
      "Seno") echo "s($1)" | bc -l ; break ;;
      "Coseno") echo "c($1)" | bc -l ; break ;;
      "Tangente") echo "s($1)/c($1)" | bc -l ; break ;;
      "Logaritmo natural") echo "l($1)" | bc -l ; break ;;
      "Exponencial") echo "e($1)" | bc -l ; break ;;
      "Múltiplo de 3") echo "$1 % 3" | bc ; break ;;
      "Sumar hasta") echo "$1 * (($1 + 1) / 2)" | bc ; break ;;
      "Sumar cuadrados hasta")
        sumaCuadrados=$(( ($1 * ($1 + 1) * (2 * $1 + 1)) / 6 ))
        echo "Resultado: $sumaCuadrados" ; break ;;
      "Sumar cubos hasta")
        sumaCubos=$(( ($1 * ($1 + 1) / 2) ** 2 ))
        echo "Resultado: $sumaCubos"; break ;;
      "Fibonacci hasta")
        a=0; b=1
        for ((i=0; i<$1; i++)); do
            echo -n "$a "
            fn=$((a + b))
            a=$b
            b=$fn
        done; break ;;
      "Salir") exit 0 ;;
      *) echo "Oye no >:c, esa opción no estaba"
    esac
  done
}

#Función con dos o más números
multiples() {
  echo "Waos, entonces, trabajamos con $# números: $@ ¿Qué hacemos con esos números?"
  select opcion in "Sumar" "Restar" "Multiplicar" "Dividir" "Promedio" "Múltiplo de" "Mínimo común múltiplo (MCM)" "Máximo común divisor (MCD)" "Salir"; do
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
      "Múltiplo de")
        num=$1
        div=$2
        resultado=$(echo "$num % $div" | bc)
        [ "$resultado" -eq 0 ] && echo "Sí" || echo "No" ; break ;;
      "Mínimo común múltiplo (MCM)")
        echo "Resultado: $(mcm $1 $2)"; break;;
      "Máximo común divisor (MCD)")
        echo "Resultado: $(mcd $1 $2)"; break;;         
      "Salir") exit 0 ;;
        *) echo "que no unu, esa opción no está >:c" ;;
      esac
    done
}

# Menú

#while true; do
  if [ $# -eq 0 ]; then
    echo "Oye pero ponele un número bestie"
  elif [ $# -eq 1 ]; then
    unoSolo $1
  else
    multiples "$@"
  fi
#done
