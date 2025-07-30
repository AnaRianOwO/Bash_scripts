#!/bin/bash 
wb=""
inputDirectory="$HOME/Downloads/webtoons/$wb"
outputDirectory="$HOME/Downloads/webtoons/$wb tmp"
outputEpub="$wb.epub"

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

  for img in "$chapterDir"/*.jpg; do
    imgName=$(basename "$img")
    echo "![Pagina $imgName]($chapterDir/$imgName)" >> "$chapterDir/content.md"
    echo "" >> "$chapterDir/content.md"
  done
  
done

echo "Generando Epub..."

pandoc "$outputDirectory"/chapter_*/*.md -o "$outputEpub" --metadata title="Webtoon UWU"

echo "¡EPUB generado como $outputEpub!"
