#!/bin/bash
set -e

if ! git diff-index --quiet HEAD --; then
  echo "Please commit/stash all your code"
  exit 1
fi

# Fresh build into a temp dir, so stale pages from old builds
# (e.g. in source/_build/html used by sphinx-autobuild) never get deployed.
BUILD_DIR=$(mktemp -d)
trap 'rm -rf "$BUILD_DIR"' EXIT
sphinx-build -E -b html -d "$BUILD_DIR/doctrees" source "$BUILD_DIR/html"

# Mirror the build into docs/: pages removed from source are removed from the site too.
rsync -a --delete \
  --exclude CNAME \
  --exclude .nojekyll \
  --exclude .buildinfo \
  "$BUILD_DIR/html/" docs/

git add --all
git commit -m "Trigger github pages deployment"
git push
