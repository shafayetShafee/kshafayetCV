#!/usr/bin/env bash
set -euo pipefail

# -----------------------------------------------------------------------------
# Defaults
# -----------------------------------------------------------------------------
DEFAULT_NAME="academic-cv"
DEFAULT_ENGINE="pdflatex"

# -----------------------------------------------------------------------------
# Helpers
# -----------------------------------------------------------------------------
usage() {
    cat <<EOF
Usage: $(basename "$0") [FILE] [ENGINE]

Compile a LaTeX document using tinytex::latexmk.

Arguments:
  FILE    TeX file name or path (default: ${DEFAULT_NAME})
          If a path is provided, the script cds to its directory.
  ENGINE  LaTeX engine: pdflatex, xelatex, lualatex, etc.
          (default: ${DEFAULT_ENGINE})

Examples:
  $(basename "$0")                    # Compile ${DEFAULT_NAME}.tex
  $(basename "$0") my-cv              # Compile my-cv.tex
  $(basename "$0") ./cv/main.tex      # Compile main.tex in ./cv/
  $(basename "$0") thesis xelatex     # Compile thesis.tex with xelatex
EOF
    exit 0
}

# Check for help flags
if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    usage
fi

# -----------------------------------------------------------------------------
# Parse arguments
# -----------------------------------------------------------------------------
INPUT="${1:-$DEFAULT_NAME}"
ENGINE="${2:-$DEFAULT_ENGINE}"

# -----------------------------------------------------------------------------
# Resolve path
# -----------------------------------------------------------------------------
# Extract directory and filename
if [[ "$INPUT" == */* ]]; then
    DIR="${INPUT%/*}"
    FILE="${INPUT##*/}"
else
    DIR="."
    FILE="$INPUT"
fi

# Strip .tex extension for NAME, if present
if [[ "$FILE" == *.tex ]]; then
    NAME="${FILE%.tex}"
else
    NAME="$FILE"
    FILE="${FILE}.tex"
fi

# Resolve to absolute directory path
if [[ "$DIR" == "." ]]; then
    ABS_DIR="$(pwd)"
else
    if [[ ! -d "$DIR" ]]; then
        echo "Error: Directory not found: $DIR" >&2
        exit 1
    fi
    ABS_DIR="$(cd "$DIR" && pwd)"
fi

# Change to target directory
cd "$ABS_DIR" || { echo "Error: Failed to enter directory: $ABS_DIR" >&2; exit 1; }

# Verify source file exists
if [[ ! -f "$FILE" ]]; then
    echo "Error: TeX file not found: $ABS_DIR/$FILE" >&2
    exit 1
fi

# -----------------------------------------------------------------------------
# Compile
# -----------------------------------------------------------------------------
echo "Compiling '${NAME}.tex' in ${ABS_DIR}"
echo "Engine: ${ENGINE}"

case "$ENGINE" in
    xelatex)  ENGINE_FLAG="-xelatex" ;;
    lualatex) ENGINE_FLAG="-lualatex" ;;
    *)        ENGINE_FLAG="-pdf" ;;
esac

latexmk -c $ENGINE_FLAG -interaction=nonstopmode -file-line-error "${NAME}.tex"

# TEXINPUTS="../styles//:" Rscript -e "tinytex::latexmk('${NAME}.tex', engine = '${ENGINE}', bib_engine = 'biber')"

# -----------------------------------------------------------------------------
# Clean up
# -----------------------------------------------------------------------------
echo "Cleaning auxiliary files..."

rm -f \
    "${NAME}.aux" \
    "${NAME}.bbl" \
    "${NAME}.bcf" \
    "${NAME}.blg" \
    "${NAME}.fdb_latexmk" \
    "${NAME}.fls" \
    "${NAME}.log" \
    "${NAME}.nav" \
    "${NAME}.out" \
    "${NAME}.run.xml" \
    "${NAME}.snm" \
    "${NAME}.synctex.gz" \
    "${NAME}.toc" \
    "${NAME}.vrb" \
    "${NAME}.xdv" \
    *~

# -----------------------------------------------------------------------------
# Open PDF
# -----------------------------------------------------------------------------
PDF_FILE="${NAME}.pdf"

if [[ -f "$PDF_FILE" ]]; then
    echo "✓ PDF generated: $PDF_FILE"

    # Try to open with the system's default viewer
    if command -v open >/dev/null 2>&1; then
        open "$PDF_FILE"
    elif command -v xdg-open >/dev/null 2>&1; then
        xdg-open "$PDF_FILE"
    elif command -v wslview >/dev/null 2>&1; then
        wslview "$PDF_FILE"
    elif [[ -n "${WSL_DISTRO_NAME:-}" ]] && command -v cmd.exe >/dev/null 2>&1; then
        cmd.exe /c start "" "$(wslpath -w "$PDF_FILE")"
    else
        echo "Open manually: $ABS_DIR/$PDF_FILE"
    fi
else
    echo "Error: PDF not generated: $PDF_FILE" >&2
    exit 1
fi
