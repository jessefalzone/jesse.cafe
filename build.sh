#!/bin/bash
set -e

if [ "$CF_PAGES_BRANCH" = "main" ]
then
  zola build
else
  zola build --base-url "$CF_PAGES_URL" --drafts
fi

# Dither output WebP images in place.
python3 << 'EOF'
from pathlib import Path
from PIL import Image

for img_path in Path("public/processed_images").rglob("*.webp"):
    img = Image.open(img_path).convert("RGB")
    dithered = img.quantize(colors=256, dither=Image.Dither.FLOYDSTEINBERG)
    dithered.convert("RGB").save(img_path, format="WEBP", quality=90)
    print(f"Dithered: {img_path}")
EOF

html-minifier -c minify.json --input-dir ./public --output-dir ./public --file-ext html
