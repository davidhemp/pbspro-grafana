#!/bin/bash

export PATH==/opt/pbs/bin/:$PATH

sudo /opt/pbs/bin/pbsnodes -a
qstat -q
qsub tests/*.pbs

QUEUE="workq"
RUNNING=$(qstat -q | grep "$QUEUE" | awk '{ print $6 }')
QUEUED=$(qstat -q | grep "$QUEUE" | awk '{ print $7 }')
n=0
if [[ $RUNNING -eq 0 && $QUEUED -eq 0 ]]; then
    exit 0
else
    echo "Still waiting"
    n=$(( n + 1))
    if [[ $n -ge 60 ]]; then
        exit 1
    fi
    sleep 10
fi
