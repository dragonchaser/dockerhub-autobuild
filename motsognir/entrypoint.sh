#!/bin/bash
CONFIGFILE=${CONFIGFILE:-/gopher/motsognir.conf}
if [ ! -f ${CONFIGFILE} ]; then
    echo "${CONFIGFILE} can not be found; bailing out!"; exit 1;
fi
echo "Using ${CONFIGFILE} to start motsognir"
trap "echo TRAPed signal" HUP INT QUIT TERM
touch /var/log/syslog
rsyslogd -n & sleep 20 &&
motsognir --config "${CONFIGFILE}"
tail -f /var/log/syslog
