#!/usr/bin/env bash
set -e

# Navigate to the Django project directory that contains manage.py
cd ShradhaHMS_Full

# Apply database migrations
python3 manage.py migrate --noinput

# Collect static files
python3 manage.py collectstatic --noinput

# Start Gunicorn server
exec python3 -m gunicorn ShradhaHMS.wsgi:application --bind 0.0.0.0:$PORT --workers 3