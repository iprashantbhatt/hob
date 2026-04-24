#!/bin/bash
cd /var/www/hob
git add .
CHANGES=$(git status --porcelain)
if [ -n "$CHANGES" ]; then
  git commit -m "Auto commit: $(date '+%Y-%m-%d %H:%M:%S')"
  git push origin main
  echo "Committed and pushed at $(date)"
else
  echo "No changes to commit"
fi
