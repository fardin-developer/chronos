from raspbian/systemd

workdir /home/chronos
run apt-get update -y && apt-get install python2.7 python-pip cron sqlite3 nginx -y
run useradd pi
run mkdir -p /home/pi/chronos_db
run pip install flask pyserial apscheduler pymodbus 
run pip install --upgrade setuptools
run pip install sqlalchemy python-socketio==0.4.1 socketIO_client uwsgi
run pip install gevent

# Try not to touch the above since installing gvenet takes too long
run pip install python-engineio==3.11.2 python-socketio==4.4.0

copy . .
copy chronos.sql /home/pi/chronos_db/
run python setup.py install
run apt-get install vim -y
run rm /etc/nginx/sites-enabled/default
run ln -s /etc/nginx/sites-enabled/chronos_conf /etc/nginx/sites-enabled/default

run uwsgi --ini /etc/uwsgi/apps-enabled/socketio_server.ini &
run uwsgi --ini /etc/uwsgi/apps-enabled/chronos.ini &
#run service chronos start
#run service nginx start

entrypoint [ "tail", "-f", "/dev/null" ]
