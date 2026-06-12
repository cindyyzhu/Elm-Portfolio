#!/bin/bash

# build-demos.sh
# Compiles each Elm project into portfolio/public/ for embedding as iframes.
# Run this from the portfolio/ directory: ./build-demos.sh

set -e

PORTFOLIO_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(dirname "$PORTFOLIO_DIR")"

echo "📦 Building Elm demo apps..."

compile() {
  local slug="$1"
  local src_dir="$ROOT_DIR/$slug"
  local out_dir="$PORTFOLIO_DIR/public/$slug"

  if [ ! -d "$src_dir" ]; then
    echo "  ⚠️  Skipping $slug — folder not found at $src_dir"
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
echo "✨ All demos compiled. Run 'elm-land server' to preview."
