#!/bin/bash
uwsgi --ini /etc/uwsgi/apps-enabled/socketio_server.ini &
service uwsgi start
service chronos start
service nginx start
tail -f /dev/null
