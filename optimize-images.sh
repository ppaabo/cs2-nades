#!/bin/bash
CONTENT_DIR="./content"
QUALITY=80

# Loop over 'images' folders inside maps/*
find "$CONTENT_DIR" -type d -name "images" | while read -r img_dir; do
    echo "Processing directory: $img_dir"

    # Store original images in a separate folder
    mkdir -p "$img_dir/_originals"

    find "$img_dir" -maxdepth 1 -type f -iname '*.png' | while read -r img; do
        filename=$(basename -- "$img")
        name="${filename%.*}"
        output_path="$img_dir/${name}.webp"
        echo "Compressing: $filename"
        cwebp -q $QUALITY "$img" -o "$output_path"
        mv "$img" "$img_dir/_originals/"
    done
done

echo "All images processed."
