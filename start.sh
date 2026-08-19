#!/usr/bin/env bash
set -e

: "${PORT:=8080}"

# If a Django wsgi module exists, run Django; else if a Flask app is present run Flask; otherwise exit.
if [ -f "./ShradhaHMS_Full/shradha/wsgi.py" ]; then
  echo "Starting Django via gunicorn (shradha.wsgi:application)"
  python -m gunicorn shradha.wsgi:application --bind 0.0.0.0:$PORT --workers 3 --threads 4 --timeout 120
elif [ -f "./ShradhaHMS_Full/manage.py" ]; then
  echo "Django project present (manage.py) — starting via gunicorn"
  python -m gunicorn shradha.wsgi:application --bind 0.0.0.0:$PORT --workers 3 --threads 4 --timeout 120
elif [ -f "./ShradhaHMS_Full/app.py" ] || [ -f "./app.py" ]; then
  echo "Starting Flask via gunicorn (app:app)"
  python -m gunicorn app:app --bind 0.0.0.0:$PORT --workers 3 --threads 4
else
  echo "ERROR: No Django (shradha.wsgi) or Flask (app.py) entrypoint found. Exiting."
  exit 1
fi
