#!/bin/bash
service uwsgi-socketio start
service uwsgi start
service chronos start
service nginx start
tail -f /dev/null
