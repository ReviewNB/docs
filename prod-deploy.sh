#!/bin/bash
set -e

if ! git diff-index --quiet HEAD --; then
  echo "Please commit/stash all your code"
  exit 1
fi

cp -r source/_build/html/* docs/
git add --all
git commit -m "Trigger github pages deployment"
git push
