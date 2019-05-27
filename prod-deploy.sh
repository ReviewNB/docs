#!/bin/bash
set -e

if ! git diff-index --quiet HEAD --; then
  echo "Please commit/stash all your code"
  exit 1
fi

cp -r build/html/* docs/