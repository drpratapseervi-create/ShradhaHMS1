#!/usr/bin/env bash
set -e
# go into folder that contains manage.py
cd ShradhaHMS_Full

# ensure static files collected before starting
python manage.py collectstatic --noinput

# run gunicorn on the project
exec gunicorn ShradhaHMS.wsgi --bind 0.0.0.0:$PORT --workers 2 --log-file -
