#!/bin/bash

sudo /opt/pbs/bin/pbsnodes -a
/opt/pbs/bin/qstat -q
/opt/pbs/bin/qsub tests/*.pbs

QUEUE="workq"
RUNNING=$(/opt/pbs/bin/qstat -q | grep "$QUEUE" | awk '{ print $6 }')
QUEUED=$(/opt/pbs/bin/qstat -q | grep "$QUEUE" | awk '{ print $7 }')
n=0
echo "$RUNNING, $QUEUED"
if [[ $RUNNING -eq 0 && $QUEUED -eq 0 ]]; then
    exit 0
else
    echo "Still waiting"
    /opt/pbs/bin/qstat -f
    n=$(( n + 1))
    if [[ $n -ge 60 ]]; then
        exit 1
    fi
    sleep 10
fi
