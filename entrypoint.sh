#!/bin/bash
uwsgi --ini /etc/uwsgi/apps-enabled/socketio_server.ini &
uwsgi --ini /etc/uwsgi/apps-enabled/chronos.ini &
service chronos start
service nginx start
tail -f /dev/null
