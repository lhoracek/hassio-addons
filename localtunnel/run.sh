#!/bin/bash
set -e

CONFIG_PATH=/data/options.json

ALIAS="$(jq --raw-output '.alias' $CONFIG_PATH)"
SERVER="$(jq --raw-output '.server' $CONFIG_PATH)"
LOCALPORT="$(jq --raw-output '.localport' $CONFIG_PATH)"
RETRY_TIME="$(jq --raw-output '.retry_time' $CONFIG_PATH)"

if [ "${ALIAS}" == "" ]
then
    SUBDOMAIN=" --subdomain {ALIAS}"
fi

if [ "${ALIAS}" == "" ]
then
    HOST=" --host http://sub.example.tld:1234 {SERVER}"
fi




CMD="/bin/bash -c 'sleep ${RETRY_TIME} && lt ${HOST} --port ${LOCALPORT} {SUBDOMAIN}"

echo "Running '${CMD}' through supervisor!"

cat > /etc/supervisor-docker.conf << EOL
[supervisord]
user=root
nodaemon=true
logfile=/dev/null
logfile_maxbytes=0
EOL
cat >> /etc/supervisor-docker.conf << EOL
[program:serveo]
command=${CMD}
autostart=true
autorestart=true
stdout_logfile=/dev/fd/1
stdout_logfile_maxbytes=0
redirect_stderr=true
EOL

exec supervisord -c /etc/supervisor-docker.conf
