#!/bin/sh
# Remove .gitkeep files from directories that have other content
# Run with -n for dry run, without for actual removal

DRY_RUN=false
[ "$1" = "-n" ] && DRY_RUN=true

find Configs Hooks -name ".gitkeep" | while read -r gitkeep; do
  dir=$(dirname "$gitkeep")

  # Count files in directory excluding .gitkeep
  file_count=$(find "$dir" -maxdepth 1 -type f ! -name ".gitkeep" | wc -l)

  # Count subdirectories
  subdir_count=$(find "$dir" -mindepth 1 -maxdepth 1 -type d | wc -l)

  if [ "$file_count" -gt 0 ] || [ "$subdir_count" -gt 0 ]; then
    if [ "$DRY_RUN" = true ]; then
      echo "WOULD REMOVE: $gitkeep"
    else
      echo "REMOVE: $gitkeep"
      rm "$gitkeep"
    fi
  else
    echo "KEEP: $gitkeep (directory empty)"
  fi
done
