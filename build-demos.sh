#!/bin/bash
set -e

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "📦 Building Elm demo apps..."

compile() {
  local slug="$1"
  local src_dir="$ROOT_DIR/$slug"
  local out_dir="$ROOT_DIR/public/$slug"

  if [ ! -d "$src_dir" ]; then
    echo "  ⚠️ Skipping $slug — folder not found at $src_dir"
    return
  fi

  echo "  🔨 Compiling $slug..."
  mkdir -p "$out_dir"
  (cd "$src_dir" && elm make src/Main.elm --output="$out_dir/elm.js" --optimize)
  echo "  ✅ $slug → public/$slug/elm.js"
}

compile newyearsmystery
compile paintbynumbers
compile unicorn

echo ""
echo "📦 Building exemplars..."

EXEMPLARS_SRC="$ROOT_DIR/public/exemplars"
EXEMPLARS_OUT="$ROOT_DIR/public/exemplars-built"

for elm_file in "$EXEMPLARS_SRC"/*.elm; do
  name=$(basename "$elm_file" .elm)
  out_dir="$EXEMPLARS_OUT/$name"
  mkdir -p "$out_dir"

  echo "  🔨 Compiling exemplar: $name"
  elm make "$elm_file" --output="$out_dir/elm.js" --optimize

  # Write a minimal HTML wrapper
  cat > "$out_dir/index.html" << EOF
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <style>
    html, body { margin: 0; padding: 0; width: 100%; height: 100%; overflow: hidden; }
  </style>
</head>
<body>
  <div id="app"></div>
  <script src="elm.js"></script>
  <script>
    var app = Elm.Main.init({ node: document.getElementById("app") });  </script>
</body>
</html>
EOF

  echo "  ✅ $name → public/exemplars-built/$name/index.html"
done

echo ""
echo "✨ All done. Run 'elm-land server' to preview."