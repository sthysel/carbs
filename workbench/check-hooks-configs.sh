#!/bin/sh
# Check which Hooks have matching Configs

echo "=== Hooks ==="
ls Hooks

printf "\n=== Configs ===\n"
ls Configs

printf "\n=== Hooks without Configs ===\n"
for hook in Hooks/*/; do
  pkg=$(basename "$hook")
  if [ ! -d "Configs/$pkg" ]; then
    echo "MISSING: $pkg"
  fi
done
