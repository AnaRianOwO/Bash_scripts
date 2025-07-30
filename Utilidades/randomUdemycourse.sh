#!/bin/bash
echo "Ingrese el número total de cursos: "
read total_cursos

cursos_por_bloque=12
total_bloques=$(( (total_cursos + cursos_por_bloque - 1) / cursos_por_bloque ))

# Seleccionar un bloque al azar
bloque_seleccionado=$(( RANDOM % total_bloques + 1 ))

# Determinar los límites del bloque seleccionado
inicio=$(( (bloque_seleccionado - 1) * cursos_por_bloque + 1 ))
fin=$(( bloque_seleccionado * cursos_por_bloque ))

if [ $fin -gt $total_cursos ]; then
  fin=$total_cursos
fi

# Mostrar información del bloque seleccionado
echo "Bloque seleccionado: $bloque_seleccionado (Cursos $inicio-$fin)"

# Seleccionar un curso dentro del bloque
curso_seleccionado=$(( RANDOM % (fin - inicio + 1) + inicio ))

echo "El curso seleccionado es el número: $curso_seleccionado"
