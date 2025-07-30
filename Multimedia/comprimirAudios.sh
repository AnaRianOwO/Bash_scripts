#!/bin/bash
bajalo="$HOME/Music/bajalo"
music="$HOME/Music"

cd $bajalo

echo $bajalo

for audio in *.mp3; do
    ffmpeg -i "$audio" \
           -b:a 96k \
           -ac 2 \
           -ar 44100 \
           -map_metadata -1 \
           "$music/${audio%.*}.mp3" && \
    echo "$audio comprimido a 96kbps"
done

echo "🎵 ¡Todos los audios optimizados en la carpeta 'comprimidos'!"
