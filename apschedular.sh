 # scripts 
 cat apschedular.sh 
#!/bin/bash

source /app/python-venv-s/notary/bin/activate
cd /home/odroid/notary/backend/notary/
export DATABASE_NAME=postgres
export POSTGRES_HOST=localhost
export POSTGRES_USER=postgres
export POSTGRES_NAME=postgres
export POSTGRES_PORT=5432
export POSTGRES_PASSWORD=postgres
export CELERY_BROKER_URL=amqp://guest:guest@localhost:5672/
export RESULT_BACKEND_URL=redis://default:redis@localhost:6379/0
export REDISIP=localhost
export REDIS_PASSWORD=redis
export HOST_IP=192.168.0.150
export SUFFEX=dev
export PRODUCTION=True
export SCHEMA_NAME=chft1
export MINIO_ROOT_USER=minio
export MINIO_ROOT_PASSWORD=bluemintminio
export AWS_STORAGE_BUCKET_NAME=notary
export MINIO_API_HOST=http://chft1.bm.local:9000
export MINIO_CLIENT_HOST=chft1.bm.local:9000
export MINIO_STORAGE_USE_HTTPS=False
export DEBUG=True
export TEMPLATES_CLONE_DEST=contracts/templates
export TEMPLATES_BRANCH=dana-chft1
export HOST_SERVER_IP=http://chft1.bm.local:8999
export LOCAL_DRIVE=true
export LOCAL_DRIVE_LINK=file:///W

make schedular-server-start 

#make systemd
cat /etc/systemd/system/apschedular.service 
[Unit]
Description=My Script Service
After=network.target

[Service]
Type=simple
User=odroid
ExecStart=/home/odroid/scripts/run/apschedular.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target



cat /etc/systemd/system/back.service 
[Unit]
Description=My Script Service
After=network.target
Requires=apschedular.service
After=apschedular.service

[Service]
Type=simple
User=odroid
ExecStart=/home/odroid/scripts/run/back.sh
Restart=on-failure
ExecStartPost=+/usr/bin/systemctl restart apschedular.service

[Install]
WantedBy=multi-user.target
