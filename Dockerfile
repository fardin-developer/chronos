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
run apt-get install vim -y

copy . .
copy chronos.sql /home/pi/chronos_db/
run python setup.py install
run rm /etc/nginx/sites-enabled/default
run ln -s /etc/nginx/sites-enabled/chronos_conf /etc/nginx/sites-enabled/default
run chmod +x entrypoint.sh

entrypoint [ "./entrypoint.sh" ]
