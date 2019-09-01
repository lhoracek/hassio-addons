#!/bin/bash
set -e

CONFIG_PATH=/data/options.json

ALIAS="$(jq --raw-output '.alias' $CONFIG_PATH)"
SERVER="$(jq --raw-output '.server' $CONFIG_PATH)"
LOCALPORT="$(jq --raw-output '.localport' $CONFIG_PATH)"
RETRY_TIME="$(jq --raw-output '.retry_time' $CONFIG_PATH)"

if [ "${ALIAS}" != "" ]
then
    SUBDOMAIN=" --subdomain {ALIAS}"
fi

if [ "${SERVER}" != "" ]
then
    HOST=" --host ${SERVER}"
fi

CMD="/bin/bash -c 'sleep ${RETRY_TIME} && lt ${HOST} --port ${LOCALPORT} {SUBDOMAIN} --local-host homeassistant"

echo "Running '${CMD}' locally!"

exec CMD
