#!/usr/bin/env bash
set -e

# Move into the project directory that has manage.py
cd ShradhaHMS_Full

# Apply database migrations
python manage.py migrate --noinput

# Collect static files
python manage.py collectstatic --noinput

# Start Gunicorn using the correct port from Railway
exec gunicorn ShradhaHMS.wsgi:application --bind 0.0.0.0:$PORT
