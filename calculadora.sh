#!/bin/bash

#Configuración
guardarHistorial() {
  local resultado="$1"
  local operacion="$2"
  shift 2
  local numeros="$@"
    echo "$resultado [$operacion] ($numeros)" >> ~/.calc_history
}

operacionUnNumero() {
  local operacion="$1"
  local expresion="$2"
  local numero="$3"

  local resultado=$(echo "$expresion" | bc -l)
  guardarHistorial "$resultado" "$operacion" "$numero"
  echo "El resultado es: $resultado"
}

menu() {
  echo "¡Solucionado! Selecciona tu próxima opción uwu"
  select option in "Seguir con el mismo número" "Seleccionar número del historial" "Escribir número" "Salir"
  case $option in 
  
  "Seguir con el mismo número")
    unoSolo $1; break;;
  #"Seleccionar número del historial")
  #"Escribir número")
  "Salir") exit 0 ;;
  *) echo "Oye no >:c, esa opción no estaba"
  
}
# MCM y MCD

mcm() {
  local actualMCM=$1
  shift

  for num in "$@"; do
    actualMCM=$(( (actualMCM * num) / $(mcd $actualMCM $num) ))
  done
  echo $actualMCM
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

mcdMultiplesNúmeros () {
  local actualMCD=$1
  shift

  for num in "$@"; do
    actualMCD=$(mcd $actualMCD $num)
    if [[ $actualMCD -eq 1 ]]; then
      break
    fi
  done

  echo $actualMCD
}

#Función con un solo número
unoSolo() {
  echo "Toncei un número uwu, ¿Qué hacemos con ese número?"
  select opcion in "Potencia (x^2)" "Raíz cuadrada" "Seno" "Coseno" "Tangente" "Logaritmo natural" "Exponencial" "Múltiplo de 3" "Sumar hasta" "Sumar cuadrados hasta" "Sumar cubos hasta" "Fibonacci hasta" "Salir"; do
    case $opcion in
    
      "Potencia (x^2)") operacionUnNumero "$opcion" "$1^2" "$1"; break ;;
      "Raíz cuadrada") operacionUnNumero "$opcion" "scale=2; sqrt($1)" "$1"; break ;;
      "Seno") operacionUnNumero "$opcion" "s($1)" "$1"; break ;;
      "Coseno") operacionUnNumero "$opcion" "c($1)" "$1"; break ;;
      "Tangente") operacionUnNumero "$opcion" "s($1)/c($1)" "$1"; break ;;
      "Logaritmo natural") operacionUnNumero "$opcion" "l($1)" "$1"; break ;;
      "Exponencial") operacionUnNumero "$opcion" "e($1)" "$1"; break ;;
      "Múltiplo de 3") operacionUnNumero "$opcion" "scale=0; $1 % 3" "$1"; break ;;
      "Sumar hasta") operacionUnNumero "$opcion" "scale=0; $1 * (($1 + 1) / 2)" "$1"; break ;;
      "Sumar cuadrados hasta")
        sumaCuadrados=$(( ($1 * ($1 + 1) * (2 * $1 + 1)) / 6 ))
        operacionUnNumero "$opcion" "$sumaCuadrados" "$1"; break ;;
      "Sumar cubos hasta")
        sumaCubos=$(( ($1 * ($1 + 1) / 2) ** 2 ))
        operacionUnNumero "$opcion" "$sumaCubos" "$1"; break ;;
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
        guardarHistorial "$suma" "$opcion" "$@"
        echo "Resultado: $suma" ; break ;;

      "Restar")
        res=$1
        shift
        for num in "$@"; do
          res=$(echo "$res - $num" | bc)
        done
        guardarHistorial "$res" "$opcion" "$@"
        echo "Resultado: $res" ; break ;;

      "Multiplicar")
        multi=1
        for num in "$@"; do
          multi=$(echo "$multi * $num" | bc)
        done
        guardarHistorial "$multi" "$opcion" "$@"
        echo "Resultado: $multi" ; break ;;
        
      "Dividir")
        div=$1
        shift
        for num in "$@"; do
          div=$(echo "scale=2; $div / $num" | bc)
        done
        guardarHistorial "$div" "$opcion" "$@"
        echo "Resultado: $div" ; break ;;
        
      "Promedio")
        suma=0
        for num in "$@"; do
          suma=$(echo "$suma + $num" | bc)
        done
        avg=$(echo "scale=2; $suma / $#" | bc)
        guardarHistorial "$avg" "$opcion" "$@"
        echo "Promedio: $avg" ; break ;;
        
      "Múltiplo de")
        num=$1
        div=$2
        resultado=$(echo "$num % $div" | bc)
        [ "$resultado" -eq 0 ] && echo "Sí" || echo "No" ; break ;;
        
      "Mínimo común múltiplo (MCM)")
        resultado=$(mcm $@)
        echo "Resultado: $resultado"
        guardarHistorial "$resultado" "$opcion" "$@"; break;;
        
      "Máximo común divisor (MCD)")
        resultado=$(mcdMultiplesNúmeros $@)
        echo "Resultado: $resultado"
        guardarHistorial "$resultado" "$opcion" "$@"; break;;
        
      "Salir") exit 0 ;;
        *) echo "que no unu, esa opción no está >:c" ;;
      esac
    done
}

# Menú

while true; do
  if [ $# -eq 0 ]; then
    echo "Oye pero ponele un número bestie"
    #menu()
  elif [ $# -eq 1 ]; then
    unoSolo $1
    #menu()
  else
    multiples "$@"
    #menu()
  fi
done
