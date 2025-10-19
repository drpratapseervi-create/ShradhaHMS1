#!/usr/bin/env bash
set -e

# default to port from environment (Railway sets PORT)
: "${PORT:=8080}"

# Example for a Flask app (adjust module name)
# If your Flask entry point is app.py and creates 'app' variable:
python -m gunicorn app:app --bind 0.0.0.0:$PORT

# OR if you already have a start command in start.sh, ensure it uses 'python' not 'python3'
# e.g. python manage.py run --host 0.0.0.0 --port $PORT   (only for dev)
