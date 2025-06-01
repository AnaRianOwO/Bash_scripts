# Mis scripts de Bash uwuwuwu
-------------------------

### Organizador de archivos.
> [!NOTE] 
> Script para organizar los archivos por su extensión de una carpeta seleccionada.

Lo que hace este script es ir archivo por archivo en una carpeta seleccionada y organizar los archivos en dicha carpeta por su extensión.
Útil para organizar una carpeta cuando hay muchos archivos.

### Curso random de Udemy.
> [!NOTE] 
> Script que selecciona un curso random de Udemy, según el número de los cursos totales.

Se selecciona un curso al azar para no tener más excusas de no realizarlo.
Principalmente selecciona un curso según la cantidad de cursos y da la ubicación según su orden.
Udemy organiza los cursos por páginas de 12 cursos cada uno. 

### Calculadora.
> [!NOTE] 
> Script calculadora, bastante artesanal ajkaajakja.

Calculadora sencilla porque mi calculadora no me funciona unu.
Funciones:

* MCM y MCD.
* Suma, resta, división y multiplicación.
* Múltiplo de.
* Potencia y raíz cuadrada.
* Seno, coseno y tangente.
* Exponencial y logaritmo natural.
* Sumar números, cuadrados y cubos hasta.

Ponle uno o más números y selecciona la opción adecuada uwu.

### Auto Git.
> [!NOTE] 
> Script para subir automáticamente avances a Github.

El script funciona en cualquier carpeta que coloque como argumento, debe de tener .git en dicha carpeta para que funcione.
Añade todos los archivos modificados, después te dice en qué rama de encuentras, solicitando que des enter para continuar.
Te pide el comentario para ponerle a los cambios, y ya por último lo sube exitosamente.


### Acortador de scripts.
> [!NOTE] 
> Script para renombrar comandos largos o scripts que no están en .local/bin/.

El script permite que coloques un comando en el mismo, ya sea uno integrado en el sistema o un script que hayas creado.
Luego verifica que existe el archivo y lo copia a .local/bin/, haciendolo un ejecutable con chmod+x primero, en donde se podrán ejecutar correctamente.
Posteriormente, crea el alias y lo guarda en .bashrc; por último,  muestra el mensaje de confirmación en cowsay.
