#!/bin/bash
# Rebuild README.pdf from README.md. Run after every version bump.
#   ./build-readme.sh
set -euo pipefail
cd "$(dirname "$0")"

CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
cp -R docs "$TMP/" 2>/dev/null || true

# markdown -> standalone HTML, skinned to match the app
pandoc README.md -f gfm -t html5 --standalone --metadata pagetitle="GraphPapers" \
  --css style.css -o "$TMP/readme.html"

cat > "$TMP/style.css" <<'CSS'
@import url('https://fonts.googleapis.com/css2?family=Instrument+Serif&family=Geist:wght@400;500;600&family=Geist+Mono:wght@400;500&display=swap');
:root{--paper:#fff;--ink:#2d3142;--muted:#4f5d75;--soft:#7a8399;--rule:rgba(45,49,66,0.12);--accent:#eb6c36}
body{font-family:'Geist',sans-serif;font-size:10.5pt;line-height:1.65;color:var(--ink);
     background:var(--paper);max-width:none;margin:0;padding:0}
h1{font-family:'Instrument Serif',serif;font-weight:400;font-size:30pt;margin:0 0 4pt;letter-spacing:-0.01em}
h2{font-family:'Instrument Serif',serif;font-weight:400;font-size:17pt;margin:22pt 0 6pt;
   padding-bottom:4pt;border-bottom:1px solid var(--rule)}
h3{font-size:11pt;font-weight:600;margin:14pt 0 4pt}
p,li{margin:0 0 7pt}
strong{font-weight:600}
a{color:var(--muted);text-decoration:none;border-bottom:1px solid var(--rule)}
code{font-family:'Geist Mono',monospace;font-size:9pt;color:var(--muted)}
img{max-width:100%;height:auto;border:1px solid var(--rule);border-radius:4px}
hr{border:none;border-top:1px solid var(--rule);margin:20pt 0}
table{border-collapse:collapse;width:100%;margin:8pt 0 12pt;font-size:9.5pt}
th{font-family:'Geist Mono',monospace;font-size:7.5pt;text-transform:uppercase;letter-spacing:0.14em;
   color:var(--soft);text-align:left;font-weight:500;padding:4pt 8pt 4pt 0;border-bottom:1px solid var(--ink)}
td{padding:4pt 8pt 4pt 0;border-bottom:1px solid var(--rule);vertical-align:top}
blockquote{margin:0;padding-left:12pt;border-left:2px solid var(--accent);color:var(--muted)}
h1+p strong{font-family:'Geist Mono',monospace;font-size:9pt;color:var(--soft);font-weight:500;letter-spacing:0.08em}
@page{size:A4;margin:20mm 22mm}
h2,h3{break-after:avoid}
table,blockquote{break-inside:avoid}
CSS

"$CHROME" --headless --disable-gpu --no-pdf-header-footer \
  --print-to-pdf="$PWD/README.pdf" "file://$TMP/readme.html" 2>/dev/null

echo "README.pdf rebuilt ($(du -h README.pdf | cut -f1))"
