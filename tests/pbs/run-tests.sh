#!/bin/bash
#Build queues and submit test jobs
mkdir -p tests/logs
sudo /opt/pbs/bin/qmgr < tests/pbs/test-cluster
sudo /opt/pbs/bin/pbsnodes -a > tests/logs/pbsnodes.log
for j in $(ls tests/pbs/jobs/); do /opt/pbs/bin/qsub tests/pbs/jobs/${j}; done
/opt/pbs/bin/qstat > tests/logs/qstat-start.log
sleep 5

#Check results

