#!/bin/bash
echo "Ingrese el número total de cursos: "
read totalCursos

cursosPorBloque=12
totalBloques=$(( (totalCursos + cursosPorBloque - 1) / cursosPorBloque ))

bloqueSeleccionado=$(( RANDOM % totalBloques + 1 ))

inicio=$(( (bloqueSeleccionado - 1) * cursosPorBloque + 1 ))
fin=$(( bloqueSeleccionado * cursosPorBloque ))

if [ $fin -gt $totalCursos ]; then
  fin=$totalCursos
fi

echo "Bloque seleccionado: $bloqueSeleccionado (Cursos $inicio - $fin)"

cursoSeleccionado=$(( RANDOM % (fin - inicio + 1) + inicio ))

echo "El curso seleccionado es el número: $cursoSeleccionado"
