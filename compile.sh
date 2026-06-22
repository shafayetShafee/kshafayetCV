#!/usr/bin/env bash
set -euo pipefail

NAME="main"

echo "Compiling ${NAME}.tex..."

Rscript -e 'tinytex::latexmk("main.tex", bib_engine = "biber")'

echo "Cleaning auxiliary files..."

rm -f \
  "${NAME}.aux" \
  "${NAME}.bbl" \
  "${NAME}.bcf" \
  "${NAME}.fdb_latexmk" \
  "${NAME}.fls" \
  "${NAME}.log" \
  "${NAME}.out" \
  "${NAME}.run.xml" \
  "${NAME}.blg" \
  "${NAME}.toc" \
  *~

PDF_FILE="${NAME}.pdf"

echo "Done → $PDF_FILE"

if [[ -f "$PDF_FILE" ]]; then
    echo "✓ Done! Opening $PDF_FILE..."
    open "$PDF_FILE"
else
    echo "Error: PDF not found: $PDF_FILE"
    exit 1
fi
