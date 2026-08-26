#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Uso: $0 <ruta_pdf> <salida_texto>" >&2
  exit 64
}

[[ $# -eq 2 ]] || usage
pdf=$1
out=$2

[[ -f "$pdf" ]] || { echo "ERROR: no existe el PDF: $pdf" >&2; exit 66; }
command -v pdftotext >/dev/null 2>&1 || {
  echo "ERROR: falta pdftotext (instalar poppler-utils)" >&2
  exit 69
}
command -v pdfinfo >/dev/null 2>&1 || {
  echo "ERROR: falta pdfinfo (instalar poppler-utils)" >&2
  exit 69
}

pages=$(pdfinfo "$pdf" | awk '/^Pages:/ {print $2; exit}')
[[ -n "$pages" ]] || { echo "ERROR: pdfinfo no pudo determinar las paginas" >&2; exit 65; }

mkdir -p "$(dirname "$out")"
pdftotext "$pdf" "$out"
chars=$(wc -m < "$out" | tr -d '[:space:]')

printf 'pages=%s\nchars=%s\ntext=%s\n' "$pages" "$chars" "$out"

if [[ "$chars" -lt 500 && "$pages" -gt 3 ]]; then
  echo "mode=vision"
else
  echo "mode=text"
fi
