# Mis scripts de Bash uwuwuwu
-------------------------

El siguiente repositorio explica el uso y el fin de los siguientes programas realizados en bash, útiles para automatizaciones en mi propio computador y como práctica del lenguaje de bash.


## Automatización:
> [!NOTE] 
> Abarca todos los scripts realizados para la automatización de tareas repititivas.

### Auto Git.
> [!NOTE] 
> Script para subir automáticamente avances a Github.

El script funciona en cualquier carpeta que coloque como argumento, debe de tener .git en dicha carpeta para que funcione y se pueda subir a Github o a cualquier otra plataforma que soporte Git como código. Además, puede traer con git pull  los cambios a la rama en la que quedaste, además de tener simplificados los comandos de git.
Añade todos los archivos modificados, después te dice en qué rama de encuentras, solicitando que des enter para continuar. Te pide el comentario para ponerle a los cambios, y ya por último lo sube exitosamente. Es importante que realices anteriormente el inicio de sesión y un repositorio, ya que solamente es un código que realiza el push y commit.

### Espacios de programación.
> [!NOTE] 
> Script para crear una sesión en tmux para programar.

El script permite que coloques una carpeta y un alias, luego cuando la ejecutes te permite una sesión en tmux con tres paneles, simulando un IDE.
Se pueden agregar cualquier carpeta, aparte de guardarse en un archivo de configuración en el perfil de usuario. Es útil de alternativa a IDE como Visual Studio Code, si bien es más complicado porque se utiliza mucho más el teclado con tmux, sirve para afianzar la agilidad al programar o escribir.


## Multimedia
> [!NOTE] 
> Aplicaciones que optimizan el uso de multimedia, desde audios hasta epub

### Epub Converter.
> [!NOTE] 
> Script para convertir una carpeta con imagenes en un epub

Un convertidor de epub que selecciona una carpeta y la convierte en un epub completo, toma una carpeta y si tiene carpetas dentro las toma como capítulos para crear el epub completo.


### Descargador de música en youtube.
> [!NOTE] 
> Script para descargar videos en youtube en formato mp3.

El script permite que se descarguen videos de Youtube en formato mp3 con base a una lista de url en un archivo txt.
Luego de buscar los videos con yt-dlp, se guarda en la carpeta principal de música. Puede ser usado para películas o listas de reproducción de música.

### Comprimidor de audios.
> [!NOTE] 
> Script para comprimir una carpeta completa de audios en un espacio más pequeño.

Muy útil cuando no se tiene suficiente espacio de memoria y no es muy importante la calidad de detalles en la música. 

## Utilidades.
> [!NOTE] 
> Aplicativos que ayudan a la productividad con objetivos sencillos.

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

Ejecutalo y verás el menú uwuwuwu.


### Acortador de scripts.
> [!NOTE] 
> Script para renombrar comandos largos o scripts que no están en .local/bin/.

El script permite que coloques un comando en el mismo, ya sea uno integrado en el sistema o un script que hayas creado.
Luego verifica que existe el archivo y lo copia a .local/bin/, haciendolo un ejecutable con chmod+x primero, en donde se podrán ejecutar correctamente.
Posteriormente, crea el alias y lo guarda en .bashrc; por último,  muestra el mensaje de confirmación en cowsay.

### Compilar C.
> [!NOTE] 
> Script que automatiza el proceso de compilar un script de C.

No es un compilador como tal, sino que realiza la creación de un script C, generando el ejecutable para que se borre en temp al apagar el computador y que se ejecute de una vez.
