#!/bin/bash 
wb=""
inputDirectory="$HOME/Downloads/webtoons/$wb"
outputDirectory="$HOME/Downloads/webtoons/$wb tmp"
outputEpub="$wb.epub"

organizadorPorImagen ($chapterDirectory) {
    for img in "$chapterDirectory"/*.jpg; do
    imgName=$(basename "$img")
    echo "![Pagina $imgName]($chapterDirectory/$imgName)" >> "$chapterDirectory/content.md"
    echo "" >> "$chapterDirectory/content.md"
  done
}

echo "Organizando imagenes por capítulos..."

for img in "$inputDirectory"/*.jpg; do
  chapter=$(basename "$img" | cut -d'_' -f1)
  mkdir -p "$outputDirectory/chapter_$chapter"
  outputImg="$outputDirectory/chapter_$chapter/$(basename "$img")"
  ffmpeg -i "$img" -q:v 5 -y "$outputImg" 2> /dev/null
done

echo "Creando markdown para cada capítulo..."

for chapterDir in "$outputDirectory"/chapter_*; do
  chapterNum=$(basename "$chapterDir" | cut -d'_' -f2)
  echo "# Capítulo $chapterNum" > "$chapterDir/content.md"
  organizadorPorImagen($chapterDir) 
done

echo "Generando Epub..."

pandoc "$outputDirectory"/chapter_*/*.md -o "$outputEpub" --metadata title="Webtoon UWU"

echo "¡EPUB generado como $outputEpub!"
