#!/bin/bash
echo "Watching /var/www/hob for changes..."
while inotifywait -r -e modify,create,delete,move \
  --exclude '(node_modules|\.git|dist|\.log)' \
  /var/www/hob/frontend/src \
  /var/www/hob/backend; do
  echo "Change detected at $(date)"
  sleep 2
  cd /var/www/hob
  git add .
  CHANGES=$(git status --porcelain)
  if [ -n "$CHANGES" ]; then
    git commit -m "Auto: $(date '+%Y-%m-%d %H:%M:%S')"
    git push origin main
    echo "Pushed to GitHub"
  fi
done
